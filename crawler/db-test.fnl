(local is (require :is))
(local fennel (require :fennel))

(local db (require :db))
(local {: init} db)


(fn test-init []
  (let [db (init "test.db")]
    (is.not-nil? db)
    (is.not-nil? db.exec)
    (db:exec "CREATE TABLE numbers(num1, num2);")))

{: test-init}
