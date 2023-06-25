(defun fontify-frame (frame)
  (interactive)
  (if window-system
      (progn
        (if (< (car (alist-get 'mm-size (frame-monitor-attributes))) 400)
            (set-face-attribute 'default (selected-frame) :height 110)
         (set-face-attribute 'default (selected-frame) :height 100)))))

(fontify-frame nil)
;; Fontify any future frames
(push 'fontify-frame after-make-frame-functions)
(add-hook 'window-size-change-functions #'fontify-frame)
