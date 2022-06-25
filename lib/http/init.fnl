(local fennel (require :fennel))
(local {: pprint} (require :lib.utils))
(local curl (require :cURL))
(local html (require :lib.html))
(local str (require :lib.str))
(local fume (require :lib.fume))
(local http-utils (require :lib.http.utils))

(fn parse-headers
  [headers]
  (->> headers
       (table.concat)
       (str.split "\r\n")
       (fume.filter (fume.complement str.blank?))
       (fume.rest)
       (fume.map http-utils.parse-header-line)
       (table.unpack)
       (fume.merge)))

(fn GET [url]
  (let [body []
        headers []]
    (with-open [h (curl.easy {:url url
                              :httpheader ["User-Agent: pse crawler 0.0.1"]
                              :followlocation true
                              :headerfunction #(table.insert headers $)
                              :writefunction {:write #(table.insert body $2)}})]
      (h:perform))
    {:headers (parse-headers headers)
     :body (table.concat body)}))

{: GET}
