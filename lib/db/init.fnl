(local fume (require :lib.fume))
(local str (require :lib.str))
(local sqlite (require :lsqlite3complete))
(local json (require :lib.dkjson))
(local fennel (require :fennel))

(var db-conn nil)

(fn create-namespace
  [db-conn namespace]
  (let [query (.. "CREATE TABLE IF NOT EXISTS "
                  namespace
                  " (key text, value text);"
                  "CREATE UNIQUE INDEX index_key on "
                  namespace
                  " (key);")]

    (assert (db-conn:exec query))))

(fn init
  [db-file namespaces]
  (assert db-file)
  (assert namespaces)
  (set db-conn (sqlite.open db-file))
  (each [_ namespace (pairs namespaces)]
    (create-namespace db-conn namespace))
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

(fn set*
  [namespace key value]
  (assert (fume.string? namespace))
  (assert (fume.string? key))
  (insert namespace [key (json.encode value)])
  value)

(fn get*
  [namespace key]
  key)

(fn close
  []
  (db-conn:close)
  :closed)

{: init
 :get get*
 :set set*
 : close}
