(local is (require :lib.is))

(local config (require :lib.config))

(local test-file :lib/config/test/test-config.json)

(fn test-config
  []
  (is.fn? config.init))

(fn test-init
  []
  (config.init test-file)
  (is.not-nil? (config.all)))


{: test-config
 : test-init}
