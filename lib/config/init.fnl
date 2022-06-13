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

(fn all
  []
  config)

(fn reset
  []
  (set config {}))

{: init
 : all
 : reset
 :get _get
 :set _set}

