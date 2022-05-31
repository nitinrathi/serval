(local fennel (require :fennel))
(local str (require :str))
(local {: pnp->> } (require :utils))
(local {: keys : filter : map} (require :fume))

(local str-test (require :str-test))
(local html-test (require :html-test))
(local db-test (require :db-test))
(local fs-test (require :fs-test))

(fn run-test
  [tests]
  (let [filter-test-fns (fn [prefix tests]
                          (->> tests
                               keys
                               (filter (str.startswith? prefix))))
        test-fns (filter-test-fns :test- tests)
        only-fns (filter-test-fns :only- tests)
        fns (match (length only-fns)
              0 test-fns
              _ only-fns)]
    (each [_ f (pairs test-fns)]
      ((. tests f)))))

(local run-tests (map run-test))

(run-tests [str-test
            html-test
            db-test
            fs-test])
