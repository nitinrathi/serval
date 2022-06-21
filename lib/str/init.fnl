(local fennel (require :fennel))
(local fume (require :lib.fume))
(local {: first
        : nil?
        : not-nil?
        : dec
        : falsey?
        : curry
        } fume)
(local {
        : gsub
        : len
        :find find-string
        :sub sub-string
        : format
        } string)

(local {:concat concat-table} table)

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

(fn _join
  [bond _list]
  (concat-table _list bond))

(local join (curry  2 _join))


(fn _split
  [pattern str splits]
  (let [start 0
        splits (or splits [])
        (split-start split-end) (find pattern str)]
    (if split-start
      (do
        (table.insert splits (sub-string str start (dec split-start)))
        (_split pattern (sub-string str (fume.inc split-end)) splits))
      (do
        (table.insert splits str)
        splits))))

(local split (curry 2 _split))

{: blank?
 : find
 : replace
 : len
 : endswith?
 : startswith?
 : lossy-compress
 : until
 : join
 : format
 : split
 }
