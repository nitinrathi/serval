(local str (require :lib.str))

(fn parse-http-start-line
  [version-string]
  (let [pattern "(%a+)/(%d+)%.?(%d*)%s+(%d+)%s+(.+)"
        (_ _ name major minor status message) (str.find pattern version-string)
        major (tonumber major)
        minor (tonumber minor)
        status (tonumber status)]
    {:protocal {: name : major : minor }
     : status
     : message}))

{: parse-http-start-line}
