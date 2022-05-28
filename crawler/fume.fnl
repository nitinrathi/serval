(local {: pprint } (require :utils))

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

(fn _filter
  [f items]
  (let [_items []]
    (each [_ item (ipairs items)]
      (if (f item)
        (table.insert _items item)))
    _items))

(fn filter
  [f items]
  (match [f items]
    [f nil] (fn [items] (_filter f items))
    [f items] (_filter f items)))

(fn map
  [f items]
  (match [f items]
    [f nil] (fn [items] (_map f items))
    [f items]  (_map f items)))

(fn __map
  [f items]
  (if (falsey? items)
    (fn [_items]
      (_map f _items))
    (_map f items)))

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
    (each [key _ (pairs x)]
      (tset _set key true))
    (keys _set)))

(fn curry1
  ;; not implemented
  [f]
  (fn [x]
    (f [x])))

(lambda curry2
  ;; not implemented
  [f x y]
  (if (falsey? x)  (x)))

(fn curry2
  ;; not implemented
  [x]
  x)

(fn curry
  [f n]
  ;; not implemented
  f)

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
 }
