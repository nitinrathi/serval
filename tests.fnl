(local fennel (require :fennel))
(local str (require :lib.str))
(local {: pnp->> } (require :lib.utils))
(local {: keys : filter : map} (require :lib.fume))

(local str-test (require :lib.str.test))
(local html-test (require :lib.html.test))
(local http-test (require :lib.http.test))
(local db-test (require :lib.db.test))
(local fs-test (require :lib.fs.test))
(local fume-test (require :lib.fume.test))
(local config-test (require :lib.config.test))

(fn run-test
  [tests]
  (let [filter-test-fns
        (fn [prefix tests]
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

(fn main
  []
  (run-tests [str-test
              html-test
              http-test
              db-test
              fs-test
              fume-test
              config-test])
  (print :tests-completed))

(main)
