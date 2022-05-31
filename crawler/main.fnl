(local http (require :http))
(local fennel (require :fennel))
(local html (require :html))
(local neturl (require :neturl))
(local fs (require :fs))
(local db (require :db))
(local sqlite (require :lsqlite3complete))
(local str (require :str))
(local {: pnp 
        : pnp->
        : pnp->>
        : pprint 
        : update-table
        : update-table-on
        } (require :utils))
(local {: complement 
        : map
        : dec
        : keys
        : inc
        : identity 
        : unique
        : filter
        : nil?
        : curry
        : always
        } (require :fume))


;(local url "https://en.wikipedia.org/wiki/Main_Page")
(local url "http://lua-users.org/wiki/PatternsTutorial")

(var content "")

(if false
  (do
    (set content (http.GET url))
    (fs.write "test.data" content))
  (set content (fs.read "test.data")))

;(pprint (html.text content))

(fn add-host-scheme
  [scheme host url]
  (-> url
      neturl.parse
      (update-table-on :scheme scheme str.blank?)
      (update-table-on :host host str.blank?)
      tostring))

(fn full-link
  [base uri]
  (let [base-uri (neturl.parse base)
        scheme (. base-uri :scheme )
        host (. base-uri :host )]
    (add-host-scheme scheme host uri)))

(fn extract
  [content]
  (let [text (html.text content)
        links (html.links content)
        title (html.title content)]
  {: text 
   : links
   : title }))

(fn crawl
  [{: uri }]
  (let [content          (http.GET uri)
        {: links : text} (extract content uri)]
    {: text : links : uri }))

(fn clean-links
  [{: links : text : uri : title }]
  (let [not-blank? (complement str.blank?)
        add-base-uri #(full-link uri $)
        until-hash (str.until "#")
        links (->> links
                   (filter not-blank?)
                   (map add-base-uri)
                   (map until-hash)
                   unique
                   )]
    {: links : text : uri : title }))

(fn clean-text
  [{: links : text : uri : title }]
  (let [text (str.lossy-compress text)]
    {: links : text : uri : title }))


(fn clean
  [page]
  (-> page
      clean-links
      clean-text))

(lambda rec-crawl
  [uri depth]
  (let [depth (dec (or depth 3))
        data  (-> {: uri }
                  crawl
                  clean)]
    (if (> depth 0)
     (each [_ link (ipairs (. data :links))]
       (rec-crawl link depth)))))

(fn crawl-test []
  (let [data (clean (crawl {:uri url}))]
    (pprint data)))

(fn db-test []
  (db.test))

(fn sha-test
  []
  (let [sha2 (require :sha2)]
    (print ( sha2.sha256 "abc"))))

(fn main []
  ;(crawl-test)
  ;(db-test)
  ;(sha-test)
  )


(main)
