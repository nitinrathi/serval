(local db (require :lib.db))
(local fs (require :lib.fs))
(local fume (require :lib.fume))
(local crawler (require :crawler))
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

(local seed "https://")

(fn main
  []
  (init {: config-file}))

(lambda rec-crawl
  [uri depth]
  (let [depth (fume.dec (or depth 3))
        data  (-> {: uri }
                  crawler.crawl
                  crawler.clean)]
    (if (> depth 0)
     (each [_ link (ipairs (. data :links))]
       (rec-crawl link depth)))))

(main)
