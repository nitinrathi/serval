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

(fn test-find
  []
  (is.nil? (str.find :d :abc))
  (is.not-nil? (str.find :a :abc))
  (is.eq? 1 (str.find :a :abc))
  (is.eq? 2 (str.find :b :abc))
  (is.eq? 2 (str.find :bc :abc)))

(fn test-replace
  []
  (is.not-nil? (str.replace :abc :def :abcdef))
  (is.eq? "" (str.replace :a :abc ""))
  (is.eq? :abcdef (str.replace :z :abc :abcdef))
  (is.eq? :aabccdef (str.replace :b :abc :abcdef))
  (is.eq? :aabcdef (str.replace :bc :abc :abcdef)))

{: test-replace
 : test-join
 : test-find
 : test-replace }
