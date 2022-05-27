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

(fn falsey?
  [x]
  (or (= nil x)
      (= false x)))

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
  (if (falsey? items)
    (fn [_items]
      (_filter f _items))
    (_filter f items)))

(fn map
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

(fn unique
  [x]
  (let [_set []]
    (each [key _ (pairs x)]
      (tset _set key true))
    (keys _set)))

{
 : first
 : dec
 : head
 : identity
 : items
 : complement
 : keys
 : map
 : filter
 : always
 : unique
 }
