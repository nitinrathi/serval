(fn write
  [filename content]
  (let [file (assert (io.open filename :wb))]
    (file:write content)
    (file:close)))

(fn read
  [filename]
  (match (io.open filename :rb)
    nil  nil
    file (file:read :*a)))

{: write
 : read }
