(local is (require :lib.is))

(local fume (require :lib.fume))

(fn test-eq?
  []
  (is.true? (fume.eq? 1 1)))


{: test-eq?}
