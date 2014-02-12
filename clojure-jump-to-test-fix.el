(defun jw-clojure-has-dir (dir)
  (member dir (split-string buffer-file-name "/")))

(defun jw-clojure-test-format ()
  (cond ((jw-clojure-has-dir "clj")  "%stest/clj/%s_test.clj")
        ((jw-clojure-has-dir "cljs") "%stest/cljs/%s_test.clj")
        (t                           "%stest/%s_test.clj")))

(defun jw-clojure-implementation-format ()
  (cond ((jw-clojure-has-dir "clj")  "%ssrc/clj/%s.clj")
        ((jw-clojure-has-dir "cljs") "%ssrc/cljs/%s.clj")
        (t                           "%ssrc/%s.clj")))

(defun jw-clojure-test-for (namespace)
  "Returns the path of the test file for the given namespace."
  (let* ((namespace (clojure-underscores-for-hyphens namespace))
         (segments (split-string namespace "\\.")))
    (format (jw-clojure-test-format)
            (file-name-as-directory
             (locate-dominating-file buffer-file-name "src/"))
            (mapconcat 'identity segments "/"))))

(defun jw-clojure-test-implementation-for (namespace)
  "Returns the path of the src file for the given test namespace."
  (let* ((namespace (clojure-underscores-for-hyphens namespace))
         (segments (split-string namespace "\\."))
         (namespace-end (split-string (car (last segments)) "_"))
         (namespace-end (mapconcat 'identity (butlast namespace-end 1) "_"))
         (impl-segments (append (butlast segments 1) (list namespace-end))))
    (format (jw-clojure-implementation-format)
            (locate-dominating-file buffer-file-name "src/")
            (mapconcat 'identity impl-segments "/"))))

(setq clojure-test-implementation-for-fn 'jw-clojure-test-implementation-for)
(setq clojure-test-for-fn 'jw-clojure-test-for)
