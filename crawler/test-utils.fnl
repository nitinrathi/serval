(local {: falsey? : nil? } (require :fume))

(fn eq?
  [left right]
  (let [matches? (match [(type left) (type right)]
                  [:number] (= left right)
                  [:string] (= left right)
                  [:boolean] (= left right)
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

{
 : eq?
 : not-nil?
 }
