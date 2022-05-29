(local test (require :test-utils))
(local fs (require :fs))
(local utils (require :utils))

(local html (require :html))
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
  (test.not-nil? (title content))
  (test.string? (title content))
  (test.eq? "Good title" (title content)))

(fn test-links
  []
  (test.not-nil? (links content))
  (test.eq? ["https://www.example1.com/"
             "https://www.example2.com/"]
            (links content)))

(fn test-text
  []
  (test.not-nil? (text content))
  (test.string? (text content))
  (test.eq? "Good link 1 Good link 2 " (text content)))

{: test-title
 : test-links
 : test-text
 }
