(local db (require :lib.db))
(local fs (require :lib.fs))
(local fume (require :lib.fume))
(local crawler (require :crawler))
(local config (require :lib.config))
(local utils (require :lib.utils))
(local {: sha256 } (require :lib.sha2))

(local config-file "config.json")


(fn init
  [{: config-file }]
  (print "init: config" config-file)
  (config.init config-file)
  (print "init: db" (config.get :db-location))
  (db.init (config.get :db-location)
           (config.get :db-namespaces))
  (fs.mkdir (config.get :repository)))

(fn write-data
  [data]
  (let [uri (. data :uri)
        text (. data :text)
        links (. data :links)
        title (. data :title)
        uri-sha (sha256 uri)
        text-sha (sha256 text)
        file-name (.. (config.get :repository) text-sha)]
    (db.set :links uri {: uri : links : text-sha : title})
    (db.set :repo uri file-name)
    (fs.write file-name text)))

(lambda rec-crawl
  [uri depth f link-filter]
  (let [depth (fume.dec (or depth 3))
        data  (-> {: uri }
                  crawler.crawl
                  crawler.clean)]
    (f data)
    (if (> depth 0)
     (each [_ link (ipairs (fume.filter link-filter (. data :links)))]
       (rec-crawl link depth f link-filter)))))

(fn crawled?
  [link]
  (let [has? (db.has? :links link)]
    (print "has? " has? link)
    (when has?
      (print "already crawled" link))
    (not has?)))

(fn main
  []
  (init {: config-file})
  (rec-crawl "https://example.com" 4 write-data crawled?))

;(main)

{: init 
 : main}
