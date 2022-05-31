(local is (require :is))

(local fs (require :fs))

(fn test-mkdir
  []
  (is.not-nil? (fs.mkdir "/tmp/test-dir"))
  (is.nil? (fs.mkdir "/test-dir"))
  (is.eq? :dir-created (fs.mkdir "/tmp/test-dir-2")))

(fn test-touch
  []
  (fs.mkdir "/tmp/very-special-dir")
  (is.nil? (fs.touch "/tmp/very-special-dir/asdasd/test-file.test-file"))
  (is.not-nil? (fs.touch "/tmp/very-special-dir/test-file.test-file"))
  (is.eq? :touched (fs.touch "/tmp/very-special-dir/test-file.test-file")))

{: test-mkdir
 : test-touch}


