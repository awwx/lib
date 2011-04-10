(test-match (json-true)
  "true" t
  "false" '<<parse-fail>>)
  
(test-match (json-false)
  "true"  '<<parse-fail>>
  "false" nil)

(testis (json-number-char #\5) t)
(testis (json-number-char #\y) nil)

(test-match (json-number)
  "123"  123
  "4.56" 4.56)

(test-match (fourhex)
  "0041"  #\A)

(test-match (json-backslash-escape)
  "\\r"     #\return
  "\\u0041" #\A)

(test-match (json-string)
  "\"\""        ""
  "\"abc\""     "abc"  
  "\"\\u0041\"" "A")

(test-match (json-array)
  "[]"           nil
  "[1,2,3]"      '(1 2 3)
  "[true,false]" '(t nil)
  "[ 1 , 2 ]"    '(1 2))

(test-match (json-value)
  "[1,[2,3,[4,5,6]],7]" '(1 (2 3 (4 5 6)) 7))

(test-match (json-object-kv)
  "\"abc\": 123"  '("abc" 123))

(testis (match "{ \"a\" : 1 }" (json-object)) (obj "a" 1))

(testis (match "{ \"a\" : 1 }" (json-object)) (obj "a" 1))

(testis (match "{ \"a\" : 1 , \"b\" : 2 }" (json-object)) (obj "a" 1 "b" 2))

(testis (match "[{\"a\":1},2]" (json-value)) (list (obj "a" 1) 2))

(testis (fromjson "123") 123)
