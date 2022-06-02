(local fume (require :lib.fume))
(local str (require :lib.str))
(local sqlite (require :lsqlite3complete))

(var db-conn nil)

(fn init
  [db-file queries]
  (assert db-file)
  (assert queries)
  (set db-conn (sqlite.open db-file))
  (fume.map #(db-conn:exec $) queries)
  db-conn)

(fn insert-statement
  [tbl vals]
  (let [parameters (->> vals
                        (fume.map (fume.always :?))
                        (str.join ","))]
    (str.format "INSERT INTO %s VALUES (%s);" tbl parameters)))

(fn insert
  [tbl vals]
  (doto (db-conn:prepare (insert-statement tbl vals))
        (: :bind_values (table.unpack vals))
        (: :step)
        (: :reset)))


(fn close
  []
  (db-conn:close)
  :closed)

{: init
 : insert
 : close}
