(local {: first
        : nil?
        : not-nil?
        : dec
        : falsey?
        : curry
        } (require :fume))
(local {
        : len
        : gsub
        :find find-string
        :sub sub-string
        } string)

(fn blank?
  [str]
  (or (falsey? str)
      (and (= :string (type str))
           (= 0 (len str)))))

(fn find
  [pattern str]
  (match [str pattern]
    [str nil] (fn [pattern] (find str pattern))
    [str pattern] (find-string str pattern)))

(fn lossy-compress
  [str] 
  "Subs bunch of whitespaces with single space."
  (pick-values 1 (gsub str "%s+" " ")))

(fn _until
  [pattern str]
  (match (find pattern str)
    nil str
    j (sub-string str 1 (dec j))))

(local until (curry _until 2))

{
 : blank?
 : find
 : len
 : lossy-compress
 : until
 }
