(local fennel (require :fennel))
(local {: pprint} (require :utils))
(local curl (require :cURL))
(local html (require :html))
(local {: identity : first : keys : items : map} (require :fume))


(fn GET [url]
  (let [response []]
    (with-open [h (curl.easy {:url url
                              :httpheader ["User-Agent: pse crawler 0.0.1"]
                              :writefunction {:write #(table.insert response $2)}})]
      (h:perform))
    (table.concat response)))


{: GET}
