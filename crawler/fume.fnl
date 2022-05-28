(local {: pprint } (require :utils))

(fn curry1
  ;; not implemented
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

(fn curry
  [f n]
  (match n
    1 (curry1 f)
    2 (curry2 f)
    3 (curry3 f)))

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

(local map (curry _map 2))

(fn _filter
  [f items]
  (let [_items []]
    (each [_ item (ipairs items)]
      (if (f item)
        (table.insert _items item)))
    _items))

(local filter (curry2 _filter))

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


{
 : first
 : dec
 : inc
 : head
 : identity
 : items
 : complement
 : keys
 : map
 : filter
 : always
 : unique
 : nil?
 : false?
 : falsey?
 : curry
 }

