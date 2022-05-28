(local store {})
(fn _set
  [key value]
  (tset store key value))

(fn _get
  [key]
  (. store key))

{:set _set
 :get _get }
