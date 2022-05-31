(local {: view} (require :fennel))
(local {: falsey? : nil?} (require :fume))

(fn eq?
  [left right]
  (let [matches? (match [(type left) (type right)]
                  [:number] (= left right)
                  [:string] (= left right)
                  [:boolean] (= left right)
                  [:table] (= (view left) (view right))
                  [:nil] (= left right)
                  _ false)]
    (if (falsey? matches?)
      (assert (values nil (.. :test-failed
                              " expected "
                              (tostring left)
                              " == "
                              (tostring right)
                              ))))))

(fn not-nil?
  [x] 
  (if (nil? x)
      (assert (values nil (.. :test-failed " expected not nil")))))

(fn nil?
  [x]
  (if (not (nil? x))
      (assert (values nil (.. :test-failed " expected nil")))))

(fn string?
  [x]
  (if (not (= "string" (type x)))
      (assert (values nil (.. :test-failed " expected string")))))

{: eq?
 : nil?
 : not-nil?
 : string?}
