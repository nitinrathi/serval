(fn write
  [filename content]
  (let [file (assert (io.open filename :wb))]
    (file:write content)
    (file:close)))

(fn read
  [filename]
  (let [file (assert (io.open filename :rb))
        content (file:read :*a)]
    (file:close)
    content))

{: write
 : read }
