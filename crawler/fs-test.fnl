(local test (require :test-utils))

(local fs (require :fs))

(fn test-mkdir
  []
  (test.not-nil? (fs.mkdir "/tmp/test-dir"))
  (test.eq? :dir-created (fs.mkdir "/tmp/test-dir-2")))

(fn test-touch
  []
  (fs.mkdir "/tmp/very-special-dir")
  (test.nil? (fs.touch "/tmp/very-special-dir/asdasd/test-file.test-file")))
  (test.not-nil? (fs.touch "/tmp/very-special-dir/test-file.test-file"))
  (test.eq? :touched (fs.touch "/tmp/very-special-dir/test-file.test-file"))

{: test-mkdir
 : test-touch}


