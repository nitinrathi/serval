(local fume (require :lib.fume))
(local sqlite (require :lsqlite3complete))

(var db-connection nil)

(fn init
  [db-file queries]
  (assert db-file)
  (assert queries)
  (set db-connection (sqlite.open db-file))
  (fume.map db-connection.exec queries)
  db-connection)

(fn add-url
  [uri data]
  )

(fn close
  []
  (db-connection:close)
  :closed)

{: init
 : close}
