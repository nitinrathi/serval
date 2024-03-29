(local is (require :lib.is))
(local fennel (require :fennel))

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
  (is.false? (fume.eq? {:foo 1 :bar 2} {:bar 2 :foo 1 :x 1}))
  (let [f (fn [] 1)
        g (fn [] 1)
        h f]
    (is.false? (fume.eq? f g))
    (is.true? (fume.eq? f h))))

(fn test-boolean?
  []
  (is.true? (fume.boolean? true))
  (is.true? (fume.boolean? false))
  (is.false? (fume.boolean? {}))
  (is.false? (fume.boolean? []))
  (is.false? (fume.boolean? "true"))
  (is.false? (fume.boolean? 1))
  (is.false? (fume.boolean? (fn [] []))))

(fn test-table?
  []
  (is.true? (fume.table? []))
  (is.true? (fume.table? {:key :value}))
  (is.false? (fume.table? true))
  (is.false? (fume.table? 1))
  (is.false? (fume.table? "true"))
  (is.false? (fume.table? "table"))
  (is.false? (fume.table? (fn [] []))))

(fn test-number?
  []
  (is.true? (fume.number? 1))
  (is.true? (fume.number? 1.2))
  (is.false? (fume.number? "1.2"))
  (is.false? (fume.number? true))
  (is.false? (fume.number? []))
  (is.false? (fume.number? {}))
  (is.false? (fume.number? {:number 1}))
  (is.false? (fume.number? (fn [] []))))

(fn test-string?
  []
  (is.true? (fume.string? :string))
  (is.true? (fume.string? "string"))
  (is.true? (fume.string? ""))
  (is.true? (fume.string? " "))
  (is.false? (fume.string? true))
  (is.false? (fume.string? 1))
  (is.false? (fume.string? []))
  (is.false? (fume.string? {}))
  (is.false? (fume.string? {:string :str}))
  (is.false? (fume.string? (fn [] []))))

(fn test-fn?
  []
  (is.true? (fume.fn? print))
  (is.true? (fume.fn? fume.fn?))
  (is.true? (fume.fn? (fn [] []))) 
  (is.false? (fume.fn? true))
  (is.false? (fume.fn? 1))
  (is.false? (fume.fn? []))
  (is.false? (fume.fn? {}))
  (is.false? (fume.fn? {:string :str})))

(fn test-type?
  []
  (is.true? (fume.fn? (fume.type? :string)))
  (is.true? (fume.type? :string " "))
  (is.false? (fume.type? :string true))
  (is.true? (fume.type? :number 1))
  (is.false? (fume.type? :number "1"))
  (is.false? (fume.type? :number {}))
  (is.true? (fume.type? :boolean false))
  (is.false? (fume.type? :boolean {}))
  (is.true? (fume.type? :table {}))
  (is.true? (fume.type? :table []))
  (is.false? (fume.type? :table :table))
  (is.true? (fume.type? :function fume.type?))
  (is.false? (fume.type? :function :table)))

(fn test-unique
  []
  (is.eq? [1 2 3 4] (fume.unique [1 2 2 3 4]))
  (is.eq? [1 2 3 5 6] (fume.unique [1 2 1 2 1 3 2 5 6]))
  (is.eq? [:a :b :c :d] (fume.sort (fume.unique [:a :b :c :d :d])))
  (is.eq? [] (fume.unique [])))

(fn test-sort
  []
  (is.eq? [1 2 3 4] (fume.sort [4 3 1 2]))
  (is.eq? [:a :b :c :d] (fume.sort [:b :c :a :d]))
  (is.eq? [-2 -1 0 1 2] (fume.sort [0 1 2 -1 -2]))
  (is.eq? [4 2 1] (fume.sort [1 2 4] (fn [x y] (> x y)))))

(fn test-dec
  []
  (is.eq? -1 (fume.dec 0))
  (is.eq? 0 (fume.dec 1)))

(fn test-inc
  []
  (is.eq? 1 (fume.inc 0)))
  (is.eq? 100 (fume.inc 99))

(fn test-always
  []
  (is.fn? (fume.always true))
  (is.eq? true ((fume.always true)))
  (is.eq? 1 ((fume.always 1) :a :b)))
  (is.eq? [] ((fume.always []) :a))


(fn test-len
  []
  (is.not-nil? (fume.len []))
  (is.eq? 0 (fume.len []))
  (is.eq? 3 (fume.len [:a :b :c]))
  (is.eq? 0 (fume.len {}))
  (is.eq? 1 (fume.len {:a :a}))
  (is.eq? 3 (fume.len :abc))
  (is.eq? 0 (fume.len ""))
  (is.nil? (fume.len fume.len))
  (is.nil? (fume.len 0)))

(fn test-rest
  []
  (is.not-nil? (fume.rest [1 2 3]))
  (is.eq? [2 3] (fume.rest [1 2 3])))

(fn test-merge
  []
  (is.not-nil? (fume.merge {:a 1} {:b 1}))
  (is.eq? {:a 1 :b 1} (fume.merge {:a 1} {:b 1}))
  (is.eq? {:b 1 :a 1} (fume.merge {:a 1} {:b 1}))
  (is.eq? {} (fume.merge))
  (is.eq? {:a 1} (fume.merge {:a 1}))
  (is.eq? {:a 1 :b 2 :c 3} (fume.merge {:a 10 :b 10 :c 10} {:a 1} {:b 2} {:c 3})))

(fn test-split
  []
  (is.not-nil? (fume.split 1 [2 3 1 4 5 6]))
  (is.eq? [[2 3] [4 5 6]] (fume.split 1 [2 3 1 4 5 6]))
  (is.eq? [[2 3] [4 5 6]] (fume.split 1 [1 2 3 1 4 5 6]))
  (is.eq? [[2 3] [4 5 6]] (fume.split 1 [1 2 3 1 4 5 6 1]))
  (is.eq? [[2 3] [4 5 6]] (fume.split 1 [1 2 3 1 1 1 1 1 4 5 6 1])))

(fn test-last
  []
  (is.not-nil? (fume.last [1 2 3]))
  (is.eq? 3 (fume.last [1 2 3]))
  (is.eq? :a (fume.last [1 2 3 :a]))
  (is.eq? :a (fume.last [:a]))
  (is.eq? nil (fume.last [])))

(fn test-butlast
  []
  (is.not-nil? (fume.butlast [1 2 3]))
  (is.eq? [1 2] (fume.butlast [1 2 3]))
  (is.eq? [1 2] (fume.butlast [1 2 3]))
  (is.eq? [] (fume.butlast [1]))
  (is.eq? [] (fume.butlast [])))

{: test-eq?
 : test-table?
 : test-boolean?
 : test-number?
 : test-string?
 : test-fn?
 : test-type?
 : test-unique
 : test-sort
 : test-dec
 : test-inc
 : test-len
 : test-rest
 : test-merge
 : test-split
 : test-last
 : test-butlast
 }


