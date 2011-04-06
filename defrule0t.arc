(def foo (x)
  0)

(defrule foo (even x)
  (* 2 x))

(testis (foo 3) 0)
(testis (foo 4) 8)
