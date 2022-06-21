(local str (require :lib.str))

(fn parse-http-start-line
  [version-string]
  (let [pattern "HTTP/(%d+)%.?(%d*)%s+(%d+)%s+(.+)" 
        (_ _ major minor status message) (str.find pattern version-string)
        major (tonumber major)
        minor (tonumber minor)
        status (tonumber status)]
    {:version {: major : minor }
     : status
     : message}))

{: parse-http-start-line}
