(local http (require :socket.http))
(local ltn12 (require :ltn12))

(fn get [url]
  (print "url is " url)
  (let [t {}
        (resp status-code headers) (http.request {:url url
                                                  :sink (ltn12.sink.table t)
                                                  :redirect true})]
    (each [key value (pairs headers)]
      (print ">" key value))
    (print "status code" status-code)
    (if (or (= 301 status-code) (= 302 status-code))
      (get headers.location)
      (table.concat t))))

;(print (get "https://w3.impa.br/~diego/software/luasocket/"))
;(print (get "http://orowealth.com"))
(print (get "https://en.wikipedia.org/wiki/Main_Page"))
