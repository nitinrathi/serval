(local fume (require :lib.fume))
(local str (require :lib.str))
(local sqlite (require :lsqlite3complete))
(local json (require :lib.dkjson))
(local fennel (require :fennel))

(var db-conn nil)

(fn create-namespace
  [db-conn namespace]
  (let [query (.. (str.format 
                    "CREATE TABLE IF NOT EXISTS %s (key text, value text);"
                    namespace)
                  (str.format
                    "CREATE UNIQUE INDEX %s_index_key on %s (key);"
                    namespace namespace))]
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

(fn delete-statement
  [namespace key]
  (str.format "DELETE from %s where key = '%s';" namespace key))

(fn delete
  [namespace key]
  (assert (db-conn:exec (delete-statement namespace key))))

(fn set*
  [namespace key value]
  (assert (fume.string? namespace))
  (assert (fume.string? key))
  (insert namespace [key (json.encode value)])
  value)

(fn get*
  [namespace key]
  (var r nil)
  (each [row (db-conn:nrows
               (str.format
                 "SELECT value from %s where key = '%s';" namespace key))]
    (set r (. row :value)))
  (and r (json.decode r)))

(fn has?
  [namespace key]
  (var r nil)
  (each [row (db-conn:nrows
               (str.format
                 "SELECT key from %s where key = '%s';" namespace key))]
    (set r (. row :key)))
  (not (not r)))

(fn close
  []
  (db-conn:close)
  :closed)

{: init
 :get get*
 :set set*
 :unset delete
 : has?
 : close}
