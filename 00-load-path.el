(setq pkgs-package-dir (concat user-specific-dir "/pkgs"))
(add-to-list 'load-path pkgs-package-dir)

(setq local-package-dir (concat user-specific-dir "/local"))
(add-to-list 'load-path local-package-dir)

(setq local-theme-dir (concat user-specific-dir "/themes"))
(add-to-list 'load-path local-theme-dir)
