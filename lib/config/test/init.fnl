(local is (require :lib.is))
(local fume (require :lib.fume))

(local config (require :lib.config))

(local test-file :lib/config/test/test-config.json)

(fn test-config
  []
  (is.fn? config.init))

(fn test-init
  []
  (config.init test-file)
  (is.not-nil? (config.all))
  (config.reset))

(fn test-get
  []
  (config.init test-file)
  (is.eq? :data/db.sqlite3 (config.get :db-location))
  (is.table? (config.get :tables))
  (config.reset))

(fn test-reset
  []
  (config.init test-file)
  (is.eq? 2 (fume.len (config.all)))
  (config.reset)
  (is.eq? 0 (fume.len (config.all)))
  (is.eq? {} (config.all)))

(fn test-init
  []
  (config.init test-file)
  (is.eq? 2 (fume.len (config.all)))
  (is.eq? :data/db.sqlite3 (config.get :db-location))
  (is.table? (config.get :tables)))

{: test-config
 : test-init
 : test-get
 : test-reset}



