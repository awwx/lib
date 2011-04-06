; regex from http://search.cpan.org/~gaas/URI-1.51/URI.pm#PARSING_URIs_WITH_REGEXP

(def parse-url (url)
  (withs ((scheme hostport path query frag)
          (re-match
           "(?:([^:/?#]+):)?(?://([^/?#]*))?([^?#]*)(?:\\?([^#]*))?(?:#(.*))?"
           url)
          (host port) (tokens hostport #\:))
    (obj scheme (sym scheme)
         hostport hostport
         host host
         port (errsafe:int port)
         path path
         query query
         frag frag)))

