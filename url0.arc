(def unpair (pairs)
  (apply + '() pairs))

(def construct-url (base . args)
  (let as (keep (fn ((k v)) v) (pair args))
    (string
     base
     (if as
         (string
          "?"
          (intersperse
           "&"
           (map (fn ((k v))
                  (string k "=" (urlencode:string v)))
                as)))))))

(mac url (base . args)
  (let a (unpair:map (fn ((k v)) (list (list 'quote k) v)) (pair args))
    `(construct-url ,base ,@a)))
