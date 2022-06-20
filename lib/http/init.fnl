(local fennel (require :fennel))
(local {: pprint} (require :lib.utils))
(local curl (require :cURL))
(local html (require :lib.html))
(local {: identity : first : keys : items : map} (require :lib.fume))
(local fume (require :lib.fume))

(fn GET [url]
  (let [body []
        headers []]
    (with-open [h (curl.easy {:url url
                              :httpheader ["User-Agent: pse crawler 0.0.1"]
                              :followlocation true
                              :headerfunction #(table.insert headers $)
                              :writefunction {:write #(table.insert body $2)}})]
      (h:perform))
    {: headers
     :body (table.concat body)}))


{: GET}
