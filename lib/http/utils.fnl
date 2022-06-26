(local str (require :lib.str))

(fn parse-http-start-line
  [start-line]
  (let [pattern "(%a+)/(%d+)%.?(%d*)%s+(%d+)%s+(.+)"
        (_ _ name major minor status message) (str.find pattern start-line)
        major (tonumber major)
        minor (tonumber minor)
        status (tonumber status)]
    {:protocal {: name : major : minor }
     : status
     : message}))

(fn parse-header-line
  [header-line]
  (let [pattern "(.+): (.+)"
    (_ _ key value) (str.find pattern header-line)]
    {key value}))

{: parse-http-start-line
 : parse-header-line}
