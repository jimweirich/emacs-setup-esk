(setq user-specific-dir esk-user-dir)
;;; (mapc 'load-file (file-expand-wildcards (concat (expand-file-name esk-user-dir) "/*.el")))

(setq pkgs-package-dir (concat user-specific-dir "/pkgs"))
(add-to-list 'load-path pkgs-package-dir)

(setq local-package-dir (concat user-specific-dir "/local"))
(add-to-list 'load-path local-package-dir)

(setq local-theme-dir (concat user-specific-dir "/themes"))
(add-to-list 'load-path local-theme-dir)
