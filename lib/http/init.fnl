(local fennel (require :fennel))
(local {: pprint} (require :lib.utils))
(local curl (require :cURL))
(local html (require :lib.html))
(local str (require :lib.str))
(local fume (require :lib.fume))
(local http-utils (require :lib.http.utils))
(local utils (require :lib.utils))

(fn parse-headers
  [headers-str]
  (->> headers-str
       (table.concat)
       (str.split "\r\n")
       (fume.split "")
       (fume.last)
       (http-utils.list->headers-table)))

(fn redirections
  [headers-str]
  (->> headers-str
       (table.concat)
       (str.split "\r\n")
       (fume.split "")
       (fume.butlast)
       (fume.map http-utils.list->headers-table)
       (fume.map #(. $ :location))))

(fn final-url
  [uri redirections]
  (or (fume.last redirections) uri))

(fn GET [uri]
  (let [body []
        headers []]
    (with-open [h (curl.easy {:url uri
                              :httpheader ["User-Agent: serval crawler 0.0.1 github.com/nitinrathi/serval"]
                              :followlocation true
                              :headerfunction #(table.insert headers $)
                              :writefunction {:write #(table.insert body $2)}})]
      (h:perform))
    (print (table.concat headers))
    {:headers (parse-headers headers)
     :redirections (redirections headers)
     :uri (final-url uri (redirections headers))
     :body (table.concat body)}))

{: GET}
