(local json (require :lib.dkjson))
(local fs (require :lib.fs))

(var config {})

(fn init
  [config-file]
  (set config (json.decode (fs.read config-file))))

(fn _get
  [key]
  (. config key))

(fn _set
  [key value]
  (tset config key value))

{: init
 :get _get
 :set _set}

