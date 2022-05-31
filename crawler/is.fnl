(local {: view} (require :fennel))
(local fume (require :fume))

(fn eq?
  [left right]
  (let [matches? (match [(type left) (type right)]
                  [:number] (= left right)
                  [:string] (= left right)
                  [:boolean] (= left right)
                  [:table] (= (view left) (view right))
                  [:nil] (= left right)
                  _ false)]
    (if (fume.falsey? matches?)
      (assert (values nil (.. :test-failed
                              " expected "
                              (tostring left)
                              " == "
                              (tostring right)
                              ))))))

(fn not-nil?
  [x] 
  (if (fume.nil? x)
      (assert (values nil (.. :test-failed " expected not nil")))))

(fn nil?
  [x]
  (if (not (fume.nil? x))
      (assert (values nil (.. :test-failed " expected nil")))))

(fn string?
  [x]
  (if (not (= "string" (type x)))
      (assert (values nil (.. :test-failed " expected string")))))

{: eq?
 : nil?
 : not-nil?
 : string?}
