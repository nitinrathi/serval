(local http-utils (require :lib.http.utils))

(local is (require :lib.is))

(fn test-http-utils-parse-http-start-line
  []
  (is.not-nil? (http-utils.parse-http-start-line "HTTP/1.1 301 Moved Permanently"))
  (is.eq? {:version {:major 1 :minor 1} :status 301 :message "Moved Permanently"}
          (http-utils.parse-http-start-line "HTTP/1.1 301 Moved Permanently"))
  (is.eq? {:version {:major 2} :status 301 :message "Moved Permanently"}
          (http-utils.parse-http-start-line "HTTP/2 301 Moved Permanently"))
  (is.eq? {:version {:major 2} :status 200 :message "OK"}
          (http-utils.parse-http-start-line "HTTP/2 200 OK"))
  )

{: test-http-utils-parse-http-start-line}
