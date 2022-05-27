(local {: view } (require :fennel))

(fn pprint
  [...]
  (print (view ...)))


(fn pnp
  [x]
  (pprint x)
  x)

(fn update-table
  [table key value]
  (tset table key value)
  table)

(fn update-table-on
  [tbl key value update-key?]
  (if (update-key? (. tbl key))
    (update-table tbl key value)
    tbl))

(fn pnp->
  [x message]
  (print message)
  (pnp x))

(fn pnp->>
  [message x]
  (print message)
  (pnp x))

{: pprint
 : pnp
 : pnp->
 : pnp->>
 : update-table
 : update-table-on
 }
