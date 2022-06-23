(local http-utils (require :lib.http.utils))
(local fennel (require :fennel))

(local is (require :lib.is))

(fn test-http-utils-parse-http-start-line
  []
  (is.not-nil?
    (http-utils.parse-http-start-line "HTTP/1.1 301 Moved Permanently"))
  (is.eq? {:protocal {:name :HTTP :major 1 :minor 1}
           :status 301
           :message "Moved Permanently"}
          (http-utils.parse-http-start-line "HTTP/1.1 301 Moved Permanently"))
  (is.eq? {:protocal {:name :HTTP :major 2}
           :status 301
           :message "Moved Permanently"}
          (http-utils.parse-http-start-line "HTTP/2 301 Moved Permanently"))
  (is.eq? {:protocal {:name :HTTP :major 2}
           :status 200
           :message "OK"}
          (http-utils.parse-http-start-line "HTTP/2 200 OK")))


(fn test-http-utils-parse-header-line
  []
  (is.not-nil? (http-utils.parse-header-line "key: value"))
  (is.eq? {:key :value } (http-utils.parse-header-line "key: value"))
  (is.eq?
    {:Content-Type "text/plain; charset=UTF-8"}
    (http-utils.parse-header-line "Content-Type: text/plain; charset=UTF-8")))

{: test-http-utils-parse-http-start-line
 : test-http-utils-parse-header-line}
