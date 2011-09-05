;;; ISpell Options

(if (file-exists-p "/usr/local/bin/aspell")
    (setq ispell-program-name "/usr/local/bin/aspell")
  (setq ispell-program-name "ispell"))


(setq ispell-grep-command "/bin/egrep")
(setq ispell-grep-options "-i")
(setq ispell-highlight-face 'underline)
;;; Choose from: highlight, modeline, secondary-selection,
;;;              region, and underline.
