(= baseops* (table))

(extend respond (req) (baseops* req!op)
  (it req))

; TODO using one of srv's defop etc. should wipe name in baseops*

(mac defop-base (name . body)
  (w/uniq request
    `(do (wipe (srvops* ',name)
               (redirector* ',name))
         (= (baseops* ',name)
            (fn (,request)
              (w/req ,request ,@body))))))

(def cook (k v (o persistent))
  (push (list k v persistent) req!cookies-to-set))

(def rmcook (k)
  (push k req!cookies-to-remove))

(def pr-cookies ()
  (each cook req!cookies-to-set
    (whenlet (k v (o persistent)) cook
      (pr "Set-Cookie: " k "=" v)
      (when persistent
        (pr "; expires=Sun, 17-Jan-2038 19:14:07 GMT"))
      (prn)))
  (each k req!cookies-to-remove
    (prn "Set-Cookie: " k "=; expires=Thu, 01 Jan 1970 00:00:00 GMT")))

(def html-content ()
  (prn header*)
  (pr-cookies)
  (prn))

(def redirect (url)
  (prn rdheader*)
  (pr-cookies)
  (prn "Location: " url)
  (prn))

(= bfnurl* "/b")

(defop-base b
  (aif (fns* (sym (arg "fnid")))
        (it)
        (redirect "deadlink")))

(mac baform (f . body)
  `(tag (form method 'post action bfnurl*)
     (fnid-field (fnid ,f))
     ,@body))

(def bflink (f)
  (string bfnurl* "?fnid=" (fnid f)))

(mac w/blink (expr . body)
  `(tag (a href (bflink (fn () ,expr)))
     ,@body))

(mac onblink (text . body)
  `(w/blink (do ,@body) (pr ,text)))
