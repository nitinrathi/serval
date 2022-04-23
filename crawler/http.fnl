(local http (require :http.request))
(local gumbo (require :gumbo))
(local fennel (require :fennel))
(local lume (require :lume))

(fn istable
  [t]
  (= "table" (type t)))

(fn get [url]
  (print "url is " url)
  (let [request (http.new_from_uri url)
        (headers stream) (request:go)
        body (stream:get_body_as_string)]
    body))

(fn text5 [html]
  (let [document (gumbo.parse html)]
    document.body.textContent))

(fn text6 [html]
  (let [document (gumbo.parse html)]
    document))


(local url "https://en.wikipedia.org/wiki/Main_Page")
;(local url "https://w3.impa.br/~diego/software/luasocket/")
;(local url "https://www.lua.org/")
;(local url "https://100x100.games")
;(print (text2 (get url)))
;(print (text3 (get url)))
;(print (text4 (get url) {:stripWhitespace true}))
(fn kk
  [tab]
  (each [key value (pairs tab)]
    (if
      (istable value) (kk value)
      (do 
        (print key ":" value)))))

(kk (text6 (get url)))
(print (istable "asd"))
;(print (fennel.view (text6 (get url))))

;(print (text (get "https://w3.impa.br/~diego/software/luasocket/")))
;(print (get "http://orowealth.com"))
;(print (get "https://en.wikipedia.org/wiki/Main_Page"))
