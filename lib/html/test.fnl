(local is (require :lib.is))
(local fs (require :lib.fs))
(local utils (require :lib.utils))

(local html (require :lib.html))
(local {: title
        : text
        : links
        } html)

(local content
  (.. "<html>"
      "<head>"
      "<title>Good title</title>"
      "</head>"
      "<body>"
      "<a href=\"https://www.example1.com/\">Good link 1 </a>"
      "<a href=\"https://www.example2.com/\">Good link 2 </a>"
      "</body>"
      "</html>"))

(fn test-title
  []
  (is.not-nil? (title content))
  (is.string? (title content))
  (is.eq? "Good title" (title content)))

(fn test-links
  []
  (is.not-nil? (links content))
  (is.eq? ["https://www.example1.com/"
             "https://www.example2.com/"]
            (links content)))

(fn test-text
  []
  (is.not-nil? (text content))
  (is.string? (text content))
  (is.eq? "Good link 1 Good link 2 " (text content)))

{: test-title
 : test-links
 : test-text}
