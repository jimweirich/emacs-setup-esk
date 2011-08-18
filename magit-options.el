;; Magit setup

(add-to-list 'load-path (concat user-specific-dir "/pkgs/magit/share/emacs/site-lisp"))
(autoload 'magit-status "magit" nil t)
(setq magit-git-executable "/usr/local/bin/git")
