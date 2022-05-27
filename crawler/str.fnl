(local {: first } (require :fume))
(local {
        : len
        : gsub
        } string)

(fn falsey?
  [x]
  (or (= nil x)
      (= false x)))

(fn blank?
  [str]
  (or (falsey? str)
      (and (= :string (type str))
           (= 0 (string.len str)))))

(fn lossy-compress
  [str] 
  "Subs bunch of whitespaces with single space."
  (pick-values 1 (gsub str "%s+" " ")))

(fn crop-hash
  [str]

  )

{: blank?
 : lossy-compress
 : len }
