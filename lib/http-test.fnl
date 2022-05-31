(local curl (require :cURL))
(local json (require :dkjson))

(λ request [url]
  (let [out []]
    (with-open [h (curl.easy {:url url
                              :httpheader ["User-Agent: Fennel example"]
                              :writefunction {:write #(table.insert out $2)}})]
      (h:perform))
    (json.decode (table.concat out "\n"))))
