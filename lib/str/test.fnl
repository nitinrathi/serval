(local is (require :lib.is))

(local str (require :lib.str))

(fn test-replace
  []
  (is.not-nil? (str.replace :c :a :abc))
  (is.eq? :aba (str.replace :c :a :abc))
  (is.eq? :abada (str.replace :c :a :abcdc)))


(fn test-join
  []
  (is.not-nil? (str.join "" [:a :b]))
  (is.eq? :ab (str.join "" [:a :b]))
  (is.eq? "a b" (str.join " " [:a :b]))
  (is.eq? "" (str.join "" []))
  (is.eq? "" (str.join :a [])))


{: test-replace
 : test-join}
