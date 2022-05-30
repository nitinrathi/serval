(local sqlite (require :lsqlite3complete))
(local store {})

(fn _set
  [key value]
  (tset store key value))

(fn _get
  [key]
  (. store key))

(fn test []
  (let [db  (sqlite.open_memory)]
    (print db)
    (assert (db:exec "CREATE TABLE test (col1, col2)"))))

(fn init
  [db-file]
  (sqlite.open db-file))


{:set _set
 :get _get
 : init
 : test}
