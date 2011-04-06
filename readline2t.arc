(testis (fromstring "header one\r\nheader two\r\n\r\nhello\nthere\n"
                    (drain (readline)))
        '("header one" "header two" "" "hello" "there"))
