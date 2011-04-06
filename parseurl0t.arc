(testis (parse-url "http://example.com:8080/")
        (obj scheme   'http
             host     "example.com"
             port     8080
             hostport "example.com:8080"
             path     "/"))

(testis (parse-url "http://example.com/foo/bar?a=1&b=2#here")
        (obj scheme   'http
             host     "example.com"
             hostport "example.com"
             path     "/foo/bar"
             query    "a=1&b=2"
             frag     "here"))
