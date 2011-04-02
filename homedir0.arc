(def homedir ((o path))
  (string (scheme (path->string (find-system-path 'home-dir)))
          path))
