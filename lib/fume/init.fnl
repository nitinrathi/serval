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

(fn last
  [x]
  (. x (# x)))

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

(fn len
  [x]
  (match (type x)
    :table (# (keys x))
    :string (string.len x)
    _ nil))

(fn true?
  [x]
  (= true x))

(fn false?
  [x]
  (= false x))

(fn nil?
  [x]
  (= nil x))

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

(fn _type?
  [type-value x]
  (= type-value (type x)))

(local type? (curry 2 _type?))

(local fn? (type? :function))

(local string? (type? :string))

(local number? (type? :number))

(local table? (type? :table))

(local boolean? (type? :boolean))

(var eq? nil)

(fn eq-table?
  [left right]
  (accumulate [equal? true
               key value (pairs (if (> (len (keys left))
                                       (len (keys right)))
                                  left
                                  right))
               :until (not equal?)]
    (eq? (. left key) (. right key))))

(set eq?
     (fn
       [left right]
       (match [(type left) (type right)]
         [:nil :nil] true
         [:number :number] (= left right)
         [:string :string] (= left right)
         [:boolean :boolean] (= left right)
         [:function :function] (= left right)
         [:table :table] (eq-table? left right)
         _ false)))


(fn sort
  [list f]
  (let [tbl []]
    (each [_ value (pairs list)]
      (table.insert tbl value))
    (table.sort tbl f)
    tbl))


(fn rest
  [list]
  (var first? true)
  (let [_rest []]
    (each [_ value (ipairs list)]
      (if first? (set first? false)
        :else (table.insert _rest value)))
    _rest))

(fn merge
  [...]
  (let [merged {}]
   (each [_ tbl (pairs [...])]
    (each [key value (pairs tbl)]
      (tset merged key value)))
   merged))

(local fennel (require :fennel))

(fn _split
  [on list]
  (var split [])
  (let [splits []]
    (each [_ value (ipairs list)]
      (if (not (eq? value on))
        (table.insert split value)
        (do
          (if (< 0 (len split))
            (table.insert splits split))
          (set split []))))
    (if (< 0 (len split))
      (table.insert splits split))
    splits))

(local split (curry 2 _split))

{: always
 : complement
 : curry
 : dec
 : true?
 : false?
 : falsey?
 : nil?
 : filter
 : first
 : last
 : head
 : identity
 : inc
 : items
 : keys
 : map
 : unique
 : type?
 : fn?
 : string?
 : number?
 : table?
 : boolean?
 : eq?
 : sort
 : len
 : rest
 : merge
 : split}


