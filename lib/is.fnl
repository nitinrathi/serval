(local {: view} (require :fennel))
(local fume (require :lib.fume))

(fn eq?
  [left right]
  (when (not (fume.eq? left right))
      (assert (values nil (.. :test-failed
                              " expected "
                              (tostring left)
                              " == "
                              (tostring right))))))

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
  (when (not (fume.type? type-value x))
    (assert (values nil (.. :test-failed " expected " type-value)))))

(local type? (fume.curry 2 _type?))

(local fn? (type? :function))

(local string? (type? :string))

(local number? (type? :number))

(local table? (type? :table))

(local boolean? (type? :boolean))


(fn true?
  [x]
  (when (not (fume.true? x))
    (assert (values nil (.. :test-failed " expected true")))))

(fn false?
  [x]
  (when (not (fume.false? x))
    (assert (values nil (.. :test-failed " expected true")))))

{: eq?
 : nil?
 : not-nil?
 : string?
 : fn?
 : number?
 : true?
 : false?
 : table?
 : boolean?}
