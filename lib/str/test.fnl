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

(fn test-len
  []
  (is.not-nil? (str.len ""))
  (is.eq? 0 (str.len ""))
  (is.eq? 1 (str.len :a))
  (is.eq? 12 (str.len "Hello world!")))

(fn test-split
  []
  (is.not-nil? (str.split "," "11,22,33"))
  (is.eq? ["11" "22" "33"] (str.split "," "11,22,33"))
  (is.eq? ["11,22,33"] (str.split "r" "11,22,33")))

{: test-replace
 : test-join
 : test-find
 : test-replace
 : test-len
 : test-split}



