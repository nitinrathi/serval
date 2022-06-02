(local db (require :lib.db))
(local fs (require :lib.fs))
(local m (require :crawler.main))
(local config (require :lib.config))
(local utils (require :lib.utils))

(local config-file "config.json")


(fn init
  [{: config-file }]
  (print "init: config" config-file)
  (config.init config-file)
  (print "init: db" (config.get :db-location))
  (db.init (config.get :db-location)
           (config.get :tables)))

(fn main
  []
  (init {: config-file}))


(main)
