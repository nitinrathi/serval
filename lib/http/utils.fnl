(local str (require :lib.str))
(local fume (require :lib.fume))

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
    {(str.lower key) value}))

(fn list->headers-table
  [headers-list]
  (->> headers-list
       (fume.filter (fume.complement str.blank?))
       (fume.filter (str.find ":"))
       (fume.map parse-header-line)
       (table.unpack)
       (fume.merge)))


{: parse-http-start-line
 : parse-header-line
 : list->headers-table}
