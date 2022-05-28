(local {: first
        : nil?
        : not-nil?
        : dec
        : falsey?
        : curry
        } (require :fume))
(local {
        : gsub
        : len
        :find find-string
        :sub sub-string
        } string)


(fn blank?
  [str]
  (or (falsey? str)
      (and (= :string (type str))
           (= 0 (len str)))))
(fn _find
  [pattern str]
  (find-string str pattern))

(local find (curry 2 _find))

(fn _replace
 [pattern replacement str] 
 (if (nil? (find pattern str))
   str
   (gsub str pattern replacement)))

(local replace (curry 3 _replace))

(fn lossy-compress
  [str] 
  "Subs bunch of whitespaces with single space."
  (pick-values 1 (gsub str "%s+" " ")))

(fn _until
  [pattern str]
  (match (find pattern str)
    nil str
    j (sub-string str 1 (dec j))))

(local until (curry 2 _until))

(fn _endswith?
  [pattern str]
  (find (.. pattern :$) str))

(local endswith? (curry 2 _endswith?))

(fn _startswith?
  [pattern str]
  (find (.. :^ pattern) str))

(local startswith? (curry 2 _startswith?))

{
 : blank?
 : find
 : replace
 : len
 : endswith?
 : startswith?
 : lossy-compress
 : until
 }
