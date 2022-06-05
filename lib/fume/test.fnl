(local is (require :lib.is))

(local fume (require :lib.fume))

(fn test-eq?
  []
  (is.true? (fume.eq? 1 1))
  (is.false? (fume.eq? true false))
  (is.false? (fume.eq? 1 2))
  (is.false? (fume.eq? {:foo :bar} {:bar :foo}))
  (is.true? (fume.eq? {:foo :bar} {:foo "bar"}))
  (is.true? (fume.eq? {:foo {:bar 2}} {:foo {:bar 2}}))
  (is.true? (fume.eq? {:foo 1 :bar 2} {:bar 2 :foo 1}))
  (let [f (fn [] 1)
        g (fn [] 1)
        h f]
    (is.false? (fume.eq? f g))
    (is.true? (fume.eq? f h))))


{: test-eq?}
