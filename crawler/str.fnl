(local {: first
        : nil?
        : not-nil?
        : falsey?
        } (require :fume))
(local {
        : len
        : gsub
        :find string-find
        } string)

(fn blank?
  [str]
  (or (falsey? str)
      (and (= :string (type str))
           (= 0 (len str)))))

(fn find
  [str pattern]
  (match [str pattern]
    [str nil] (fn [pattern] (find str pattern))
    [str pattern] (string-find str pattern)))

(fn lossy-compress
  [str] 
  "Subs bunch of whitespaces with single space."
  (pick-values 1 (gsub str "%s+" " ")))


{
 : blank?
 : find
 : len
 : lossy-compress
 }
