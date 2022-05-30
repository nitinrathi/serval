(local test (require :test-utils))

(local str (require :str))

(fn test-replace
  []
  (test.not-nil? (str.replace :c :a :abc))
  (test.eq? :aba (str.replace :c :a :abc))
  (test.eq? :abada (str.replace :c :a :abcdc)))


(fn test-join
  []
  (test.not-nil? (str.join "" [:a :b]))
  (test.eq? :ab (str.join "" [:a :b]))
  (test.eq? "a b" (str.join " " [:a :b]))
  (test.eq? "" (str.join "" []))
  (test.eq? "" (str.join :a [])))


{: test-replace
 : test-join}
