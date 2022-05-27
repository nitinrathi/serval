(local http (require :http))
(local html (require :html))
(local neturl (require :neturl))
(local fs (require :fs))
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
        : identity 
        : unique
        : filter
        : always } (require :fume))

;; three different urls to read data from

;(local url "https://en.wikipedia.org/wiki/Main_Page")
;(local url "https://www.hytradboi.com/")
;(local url "https://100x100.games")
;(local url "https://www.heinrichhartmann.com/")
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
  [uri]
  (let [content          (http.GET uri)
        {: links : text} (extract content uri)

        full-links-fn    (map #(full-link uri $))
        links            (filter (complement str.blank?) links)
        links            (full-links-fn links)
        text             (str.lossy-compress text)

        ]
    {: text : links}))

;(local data (crawl url))
;(local data (extract content))

;(pprint (str.lossy-compress (. data :text)))
;(pprint (. data :links))
;(pprint (. data :title))


(fn 
  rec-crawl
  [url depth]
  (print depth url)
  (let [depth (or depth 3)
        data (crawl url)
        depth (dec depth) ]

    (pprint (. data :links))

    (if (> depth 0)
     (each [_ link (ipairs (. data :links))]
       (rec-crawl link depth)))))

;; imp
;(print (rec-crawl url 1))

(fn crop-hash
  [url]
  ()
  )

(pprint (unique [1 2 3 4 4 5]))
