(local str (require :lib.str))

(fn create-cmd-str
  [cmd]
  (.. (str.join " " cmd)
      " 2>&1"))

(fn run
  [cmd]
  (let [cmd (-> cmd
                create-cmd-str
                (io.popen :r))
        output (cmd:read :*a)]
    output))

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
  (match (run [:mkdir :-p path])
      "" :dir-created
      error (values nil error)))

(fn touch
  [path]
  (match (run [:touch path])
      "" :touched
      _ (values nil _)))

(fn temp
  []
  (run [:mktemp :-u]))


{: mkdir
 : touch
 : temp
 : write
 : read}
