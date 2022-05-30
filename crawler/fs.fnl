(local str (require :str))

(fn create-cmd
  [cmd]
  (.. (str.join " " cmd)
      " 2>&1"))

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

(fn mkdir
  [path]
  (let [cmd (-> [:mkdir :-p path]
                create-cmd
                os.execute)]
    (match cmd
      true :dir-created
      _ nil)))

(fn touch
  [path]
  (let [cmd (-> [:touch path]
                create-cmd
                (io.popen :r))
        output (cmd:read :*a)]
    (match output
      "" :touched
      _ nil)))

{: mkdir
 : touch
 : write
 : read }
