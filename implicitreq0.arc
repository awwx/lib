(implicit req)

(mac idefop (name . body)
  (w/uniq request
    `(defop ,name ,request
       (w/req ,request ,@body))))

(mac idefopr (name . body)
  (w/uniq request
    `(defopr ,name ,request
       (w/req ,request ,@body))))

(extend arg args (is len.args 1)
  (arg req car.args))

(mac iaform (f . body)
  (w/uniq request
    `(tag (form method 'post action fnurl*)
       (fnid-field (fnid (fn (,request)
                           (prn)
                           (w/req ,request ,f))))
       ,@body)))

(def iflink (f)
  (string fnurl* "?fnid=" (fnid (fn (req) (w/req req (prn) (f))))))

(mac iw/link (expr . body)
  `(tag (a href (iflink (fn () ,expr)))
     ,@body))

(mac ionlink (text . body)
  `(w/link (do ,@body) (pr ,text)))
