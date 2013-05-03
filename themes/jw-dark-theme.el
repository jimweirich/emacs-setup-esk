(deftheme jw-dark
  "Created 2012-08-01.")

;;; Possible Fonts (if installed):
;;; * "Monaco" / "apple"
;;; * "Menlo" / "apple"
;;; * "Bitstream Vera Sans Mono" / "bitstream"
;;; * "Source Code Pro" / "adobe"
;;; * "Envy Code R" / "apple"

(custom-theme-set-faces
 'jw-dark
 '(default ((t (:family "Menlo" :foundry "apple" :width normal :height 220 :weight normal :slant normal :underline nil :overline nil :strike-through nil :box nil :inverse-video nil :foreground "#f6f3e8" :background "#000000" :stipple nil :inherit nil))))
 '(cursor ((t (:background "#ff0000"))))
 '(fixed-pitch ((t (:family "Monospace"))))
 '(variable-pitch ((t (:family "Sans Serif"))))
 '(escape-glyph ((t (:weight bold :foreground "#ddaa6f"))))
 '(minibuffer-prompt ((t (:weight regular :box nil :foreground "yellow" :background "black"))))
 '(highlight ((t (:underline nil :background "#161616"))))
 '(region ((t (:foreground "#f6f3e8" :background "#444444"))))
 '(shadow ((((class color grayscale) (min-colors 88) (background light)) (:foreground "grey50")) (((class color grayscale) (min-colors 88) (background dark)) (:foreground "grey70")) (((class color) (min-colors 8) (background light)) (:foreground "green")) (((class color) (min-colors 8) (background dark)) (:foreground "yellow"))))
 '(secondary-selection ((t (:foreground "#f6f3e8" :background "#333366"))))
 '(trailing-whitespace ((t (:background "#ff4242"))))
 '(font-lock-builtin-face ((t (:foreground "#e5786d"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "gray50" :inherit (font-lock-comment-face)))))
 '(font-lock-comment-face ((t (:foreground "#8F8A90" :slant italic))))
 '(font-lock-constant-face ((t (:foreground "#d57d62" :weight regular))))
 '(font-lock-doc-face ((t (:foreground "moccasin" :inherit (font-lock-string-face)))))
 '(font-lock-function-name-face ((t (:weight regular :foreground "#cae682"))))
 '(font-lock-keyword-face ((t (:foreground "#00cc00" :weight regular))))
 '(font-lock-negation-char-face ((t nil)))
 '(font-lock-preprocessor-face ((t (:foreground "gold" :inherit (font-lock-builtin-face)))))
 '(font-lock-regexp-grouping-backslash ((t (:foreground "#E9C062" :weight bold))))
 '(font-lock-regexp-grouping-construct ((t (:foreground "red" :weight bold))))
 '(font-lock-string-face ((t (:foreground "#E6ED18"))))
 '(font-lock-type-face ((t (:foreground "#b2b2ff" :weight regular))))
 '(font-lock-variable-name-face ((t (:foreground "#dea600" :weight regular))))
 '(font-lock-warning-face ((t (:foreground "pink" :weight bold))))
 '(button ((t (:underline t :foreground "#f6f3e8" :background "#333333" :inherit (link)))))
 '(link ((t (:underline t :foreground "#8ac6f2"))))
 '(link-visited ((t (:underline t :foreground "#e5786d" :inherit (link)))))
 '(fringe ((t (:background "#303030"))))
 '(header-line ((t (:box nil :inverse-video t :foreground "#e7f6da" :background "#303030" :inherit (mode-line)))))
 '(tooltip ((t (:foreground "black" :background "lightyellow" :inherit (variable-pitch)))))
 '(mode-line ((t (:family "DejaVu Sans" :box (:line-width -1 :color "red" :style released-button) :foreground "#f6f3e8" :background "#444444"))))
 '(mode-line-buffer-id ((t (:weight bold :foreground "blue4"))))
 '(mode-line-emphasis ((t (:weight bold))))
 '(mode-line-highlight ((((class color) (min-colors 88)) (:box (:line-width 2 :color "grey40" :style released-button))) (t (:inherit (highlight)))))
 '(mode-line-inactive ((t (:weight light :box (:line-width -1 :color nil :style released-button) :foreground "#857b6f" :background "#444444" :inherit (mode-line)))))
 '(isearch ((t (:foreground "#857b6f" :background "#343434"))))
 '(isearch-fail ((((class color) (min-colors 88) (background light)) (:background "RosyBrown1")) (((class color) (min-colors 88) (background dark)) (:background "red4")) (((class color) (min-colors 16)) (:background "red")) (((class color) (min-colors 8)) (:background "red")) (((class color grayscale)) (:foreground "grey")) (t (:inverse-video t))))
 '(lazy-highlight ((t (:foreground "#a0a8b0" :background "#384048"))))
 '(match ((t (:background "DeepPink4"))))
 '(next-error ((t (:inherit (region)))))
 '(query-replace ((t (:inherit (isearch))))))

(provide-theme 'jw-dark)
