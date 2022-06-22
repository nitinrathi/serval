(local fennel (require :fennel))
(local {: pprint} (require :lib.utils))
(local curl (require :cURL))
(local html (require :lib.html))
(local str (require :lib.str))
(local fume (require :lib.fume))

(fn parse-headers
  [headers]
  (fume.filter (fume.complement str.blank?) (str.split "\r\n" headers)))

(fn GET [url]
  (let [body []
        headers []]
    (with-open [h (curl.easy {:url url
                              :httpheader ["User-Agent: pse crawler 0.0.1"]
                              :followlocation true
                              :headerfunction #(table.insert headers $)
                              :writefunction {:write #(table.insert body $2)}})]
      (h:perform))
    {:headers (parse-headers (table.concat headers))
     :
     :body (table.concat body)}))

{: GET}
