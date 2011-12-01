;; Night Colour Theme for Emacs
;;
;; Defines a colour scheme resembling that of the original TextMate Twilight colour theme.
;; To use add the following to your .emacs file (requires the color-theme package):
;;
;; (require 'color-theme)
;; (color-theme-initialize)
;; (load-file "~/.emacs.d/twilight-emacs/color-theme-twilight.el")
;;
;; And then (color-theme-twilight) to activate it.
;;
;; Several areas still require improvement such as recognition of code that ruby-mode doesn't
;; yet pick up (eg. parent classes), Rails/Merb keywords, or non Ruby code related areas
;; (eg. dired, HTML, etc). Please feel free to customize further and send in any improvements,
;; patches most welcome.
;;
;; MIT License Copyright (c) 2008 Marcus Crafter <crafterm@redartisan.com>
;; Credits due to the excellent TextMate Twilight theme
;;
;; Modified by Jim Weirich

(require 'color-theme)
(require 'colman)

;;;###autoload
(defun color-theme-night ()
  "Color theme by Marcus Crafter, based off the TextMate Twilight theme, created 2008-04-18"
  (interactive)
  (let* ((aquamarine "Aquamarine")
         (black "#000000")
         (fire-brick "FireBrick")
         (green "#00FF00")
         (pink "Pink")
         (red "red")
         (sea-green "SeaGreen")
         (sienna "sienna1")
         (slate-blue "SlateBlue")
         (snow "snow")
         (purple "#f175ff")
         (white "white")
         (yellow "yellow")
         (mute-yellow "#E6ED18")
         (near-black "#121212")
         (dark-gray "#303030")
         (dark-red "#660000")
         (blue "#0000ff")
         (gun-blue "#7587A6")
         (light-orange "#DEA600")
         (slate-green "#8F9D6A")
         (mid-gray "#8F8A90")
         (brown "#9B703F")
         (brownish "#BB905F")
         (kacki "#CCCC88")
         (mud-red "#CF6A4C")
         (deep-red "#dd1144")
         (dirty-yellow "#E9C062")
         (light-brown "#EDA869")
         (off-white "#F8F8F8"))
    (color-theme-install
     `(color-theme-night
       ((background-color . ,black)
        (background-mode . dark)
        (border-color . ,black)
        (cursor-color . ,red)
        (foreground-color . ,off-white)
        (mouse-color . ,sienna))
       (default ((t (:background ,black :foreground ,white))))
       (blue ((t (:foreground ,blue))))
       (bold ((t (:bold t))))
       (bold-italic ((t (:bold t))))
       (border-glyph ((t (nil))))
       (buffers-tab ((t (:background ,black :foreground ,white))))
       (compilation-info ((t (:foreground "#00aa00"))))
       (font-lock-builtin-face ((t (:foreground ,white))))
       (font-lock-comment-face ((t (:foreground ,mid-gray))))
       (font-lock-constant-face ((t (:foreground ,(lighten mud-red 10)))))
       (font-lock-doc-string-face ((t (:foreground ,mute-yellow))))
       (font-lock-doc-face ((t (:foreground ,(lighten fire-brick 20)))))
       (font-lock-function-name-face ((t (:foreground ,(darken green 20)))))
       (font-lock-keyword-face ((t (:foreground ,purple))))
       (font-lock-preprocessor-face ((t (:foreground ,aquamarine))))
       (font-lock-reference-face ((t (:foreground ,slate-blue))))

       (font-lock-regexp-grouping-backslash ((t (:foreground ,dirty-yellow))))
       (font-lock-regexp-grouping-construct ((t (:foreground ,red))))

       (font-lock-string-face ((t (:foreground ,mute-yellow))))
       (font-lock-type-face ((t (:foreground ,(lighten blue 70)))))
       (font-lock-variable-name-face ((t (:foreground ,light-orange))))
       (font-lock-warning-face ((t (:bold t :foreground ,pink))))
       (gui-element ((t (:background ,dark-gray :foreground ,mid-gray))))
       (region ((t (:background ,(lighten dark-gray 10)))))
       (mode-line ((t (:background ,mid-gray :foreground ,black))))
       (mode-line-inactive ((t (:background ,dark-gray :foreground ,black))))
       (highlight ((t (:background ,(lighten near-black 20)))))
       (highline-face ((t (:background ,sea-green))))
       (italic ((t (nil))))
       (left-margin ((t (nil))))
       (text-cursor ((t (:background ,yellow :foreground ,black))))
       (toolbar ((t (nil))))
       (underline ((nil (:underline nil))))
       (zmacs-region ((t (:background ,snow :foreground ,black))))
       (show-paren-match ((t (:foreground ,green :background ,(darken kacki 70)))))
       (show-paren-mismatch ((t (:background ,deep-red))))
       (trailing-whitespace ((t (:background ,dark-red))))
       (yaml-tab-face ((t (:foreground ,black :background ,red))))))))

(provide 'color-theme-night)
