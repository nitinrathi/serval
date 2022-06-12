(local is (require :lib.is))

(local config (require :lib.config))

(fn test-config
  []
  (is.fn? config.init))

{: test-config}
