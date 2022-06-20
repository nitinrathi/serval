(local http (require :lib.http))
(local fennel (require :fennel))
(local html (require :lib.html))
(local neturl (require :lib.neturl))
(local fs (require :lib.fs))
(local db (require :lib.db))
(local sqlite (require :lsqlite3complete))
(local str (require :lib.str))
(local puremagic (require :lib.puremagic))
(local {: pnp 
        : pnp->
        : pnp->>
        : pprint 
        : update-table
        : update-table-on
        } (require :lib.utils))
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
        } (require :lib.fume))

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
        scheme (. base-uri :scheme)
        host (. base-uri :host)]
    (add-host-scheme scheme host uri)))

(fn mime-type
  [content]
  (puremagic.via_content content ""))

(fn extract-html
  [content]
  (let [text (html.text content)
        links (html.links content)
        title (html.title content)]
    {: text 
     : links
     : title}))

(fn extract-plain-text
  [content]
  {:text content
   :links []
   :title ""})

(fn extract
  [content]
  (print "crawler.extract: mime-type" (mime-type content))
  (match (mime-type content)
    :text/html (extract-html content)
    :text/plain (extract-plain-text content)
    _ {:text "" :links [] :title ""}))


(fn crawl
  [{: uri}]
  (print "crawler.crawl: uri" uri)
  (let [{:body content}          (http.GET uri)
        {: links : text : title } (extract content uri)]
    {: text : links : uri : title}))

(fn clean-links
  [{: links : text : uri : title}]
  (let [not-blank? (complement str.blank?)
        add-base-uri #(full-link uri $)
        until-hash (str.until "#")
        links (->> links
                   (filter not-blank?)
                   (map add-base-uri)
                   (map until-hash)
                   unique)]
    {: links : text : uri : title}))

(fn clean-text
  [{: links : text : uri : title}]
  (let [text (str.lossy-compress text)]
    {: links : text : uri : title}))


(fn clean
  [page]
  (-> page
      clean-links
      clean-text))


{: crawl
 : clean}

