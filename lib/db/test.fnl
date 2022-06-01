(local is (require :lib.is))
(local fs (require :lib.fs))
(local fennel (require :fennel))

(local db (require :lib.db))
(local {: init} db)


(fn test-init []
  (let [db (init (fs.temp) [])]
    (is.not-nil? db)
    (is.not-nil? db.exec)
    (is.fn? db.exec)
    (is.not-nil? (db:exec "CREATE TABLE numbers(num1, num2);"))))

{: test-init}
