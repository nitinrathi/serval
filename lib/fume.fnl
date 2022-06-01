(local {: pprint } (require :lib.utils))

(fn curry1
  [f]
  (fn [x]
    (f [x])))

(lambda curry2
  [f]
  (fn [x y]
    (match [x y]
      [x nil] (fn [y] (f x y)) 
      [x y] (f x y) )))

(lambda curry3
  [f]
  (fn [x y z]
    (match [x y z]
      [x nil nil] (curry2 (fn [y z] (f x y z)))
      [x y nil] (fn [z] (f x y z))
      [x y z] (f x y z))))

(lambda curry4
  [f]
  (fn [w x y z]
    (match [w x y z]
      [w nil nil nil] (curry3 (fn [x y z] (f w x y z)))
      [w x nil nil] (curry2 (fn [y z] (f w x y z)))
      [w x y nil] (fn [z] (f w x y z))
      [w x y z] (f w x y z))))

(fn curry
  [n f]
  (match n
    1 (curry1 f)
    2 (curry2 f)
    3 (curry3 f)
    4 (curry4 f)))

(fn identity
  [x]
  x)

(fn first
  [x]
  (. x 1))

(local head first)

(fn keys
  [x]
  (let [_keys []]
    (each [key _ (pairs x)]
      (table.insert _keys key))
    _keys))

(fn items
  [x]
  (let [_items []]
    (each [_ item (pairs x)]
      (table.insert _items item))
    _items))


(fn false?
  [x]
  (= false x))

(fn nil?
  [x]
  (= x nil))

(fn falsey?
  [x]
  (or (nil? x)
      (false? x)))

(fn _map
  [f items]
  (let [_items []]
    (each [_ item (ipairs items)]
      (table.insert _items (f item)))
    _items))

(local map (curry  2 _map))

(fn _filter
  [f items]
  (let [_items []]
    (each [_ item (ipairs items)]
      (if (f item)
        (table.insert _items item)))
    _items))

(local filter (curry 2 _filter))

(fn complement
  [f]
  (fn [...]
    (not (f ...))))

(fn always
  [x]
  (fn [] x))


(fn dec
  [x]
  (- x 1))

(fn inc
  [x]
  (+ x 1))

(fn unique
  [x]
  (let [_set []]
    (each [_ key (pairs x)]
      (tset _set key true))
    (keys _set)))


{: always
 : complement
 : curry
 : dec
 : false?
 : falsey?
 : filter
 : first
 : head
 : identity
 : inc
 : items
 : keys
 : map
 : nil?
 : unique}

