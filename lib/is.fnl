(local {: view} (require :fennel))
(local fume (require :lib.fume))

(fn eq?
  [left right]
  (let [matches? (match [(type left) (type right)]
                  [:number] (= left right)
                  [:string] (= left right)
                  [:boolean] (= left right)
                  [:table] (= (view left) (view right))
                  [:nil] (= left right)
                  _ false)]
    (when (fume.falsey? matches?)
      (assert (values nil (.. :test-failed
                              " expected "
                              (tostring left)
                              " == "
                              (tostring right)
                              ))))))

(fn not-nil?
  [x] 
  (when (fume.nil? x)
      (assert (values nil (.. :test-failed " expected not nil")))))

(fn nil?
  [x]
  (when (not (fume.nil? x))
      (assert (values nil (.. :test-failed " expected nil")))))

(fn _type?
  [type-value x]
  (when (not (= type-value (type x)))
    (assert (values nil (.. :test-failed " expected " type-value)))))

(local type? (fume.curry 2 _type?))

(local fn? (type? :function))

(local string? (type? :string))

(local number? (type? :number))

(local table? (type? :table))

{: eq?
 : nil?
 : not-nil?
 : string?
 : fn?
 : number?
 : table?}
