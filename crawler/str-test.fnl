(local test (require :test-utils))
(local str (require :str))

(fn test-replace
  []
  (test.not-nil? (str.replace :c :a :abc))
  (test.eq? (str.replace :c :a :abc) :aba)
  (test.eq? (str.replace :c :a :abcdc) :abada))




(fn jj-test
  []
  (print "only"))

{: test-replace
 : jj-test }
