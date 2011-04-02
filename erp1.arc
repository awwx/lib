(mac erp (x)
  (w/uniq (gx)
    `(let ,gx ,x
       (w/stdout (stderr)
         (write ',x)
         (disp ": ")
         (write ,gx)
         (disp #\newline))
       ,gx)))
