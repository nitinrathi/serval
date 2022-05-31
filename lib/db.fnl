(local sqlite (require :lsqlite3complete))

(var db-connection nil)

(fn test []
  (let [db  (sqlite.open_memory)]
    (print db)
    (assert (db:exec "CREATE TABLE test (col1, col2)"))))

(fn init
  [db-file]
  (set db-connection (sqlite.open db-file))
  db-connection)

(fn close
  []
  (db-connection:close)
  :closed)

{: init
 : close
 : test}
