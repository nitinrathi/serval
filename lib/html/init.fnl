(local gumbo (require :gumbo))
(local {: parse } gumbo)
(local fume (require :lib.fume))
(local {: first : map : keys } fume)

(fn hello
  []
  (print "hello"))


(fn removeElementsByTagName
  [parsed-html tag-name]
  (each [_ elem (ipairs (parsed-html:getElementsByTagName tag-name))]
    (elem:remove))
  parsed-html)

(fn text
  [html-content]
  (-> html-content
      parse
      (removeElementsByTagName :style)
      (removeElementsByTagName :script)
      (. :body)
      (. :textContent)))

(fn links
  [html-content]
  (let [get-hrefs (map (fn [elem] (elem:getAttribute :href)))]
    (-> html-content
        parse
        (. :links)
        get-hrefs)))


(fn title
  [html-content]
  (-> html-content
        parse
        (: :getElementsByTagName :title)
        first
        (or {})
        (. :innerHTML)
        (or "")))

{: title
 : text
 : links}
