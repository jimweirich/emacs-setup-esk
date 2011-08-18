;;; Window Manaaging ==================================================

(defun jw-minibuffer-window-p (win)
  (and win
       (string-match "Minibuf" (buffer-name (window-buffer win)))))

(defun jw-window-at-origin ()
  (window-at 0 0))

(defun jw-neighbor-window (win)
  "Return a neighboring window to WIN. 
Prefer windows on the right to those below.  Might return the minibuffer."
  (let* ((edges (window-edges win))
         (left (caddr edges))
         (bottom (cadddr edges)))
    (cond ((window-at left 0))
          ((window-at 0 bottom)))))

(defun jw-neighbor-edit-window (win)
  "Return a neighboring edit window to WIN.
Never returns the minibuffer."
  (let ((neighbor (jw-neighbor-window win)))
    (if (jw-minibuffer-window-p neighbor)
        nil
      neighbor)))

(defun jw-neighboring-windows (buf1 buf2)
  (let* ((w1 (jw-window-at-origin))
         (w2 (jw-neighbor-edit-window w1)))
    (set-window-buffer w1 buf1)
    (set-window-buffer w2 buf2)
    (select-window w2)))

(defun jw-push-buffer (buffer)
  "Push a new buffer onto the screen. 
Current buffer goes to first position."
  (if (= 2 (count-windows))
      (jw-neighboring-windows
       (window-buffer (selected-window))
       buffer)
    (switch-to-buffer buffer)))

;; Courtesy of Steve Yegge (http://steve.yegge.googlepages.com/my-dot-emacs-file)
(defun jw-swap-windows ()
 "If you have 2 windows, it swaps them."
 (interactive)
 (cond ((not (= (count-windows) 2))
        (message "You need exactly 2 windows to do this."))
       (t
        (let* ((w1 (first (window-list)))
               (w2 (second (window-list)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (other-window 1)))))

