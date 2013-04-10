;; Magit setup

(add-to-list 'load-path (concat user-specific-dir "/pkgs/magit/share/emacs/site-lisp"))
(autoload 'magit-status "magit" nil t)
(cond ((file-readable-p "/usr/local/bin/git")
       (setq magit-git-executable "/usr/local/bin/git"))
      ((file-readable-p "/usr/bin/git")
       (setq magit-git-executable "/usr/bin/git"))
      (t (setq magit-git-executable "git")))
"/usr/local/bin/git"
