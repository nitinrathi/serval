(local is (require :is))

(local fs (require :fs))

(fn test-mkdir
  []
  (is.not-nil? (fs.mkdir (fs.temp)))
  (is.nil? (fs.mkdir "/test-dir-in-root"))
  (is.eq? :dir-created (fs.mkdir (fs.temp))))

(fn test-touch
  []
  (is.nil? (fs.touch "/test-file-in-root"))
  (is.nil? (fs.touch (.. (fs.temp) "/temp-file")))
  (is.not-nil? (fs.touch (fs.temp)))
  (is.eq? :touched (fs.touch (fs.temp))))

(fn test-temp
  []
  (is.not-nil? (fs.temp))
  (is.string? (fs.temp)))

{: test-mkdir
 : test-touch
 : test-temp}


