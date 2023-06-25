;; (use-package paper-theme :ensure t :defer)

(use-package modus-themes :ensure t)

(use-package zenburn-theme
  :ensure t
  ;; :defer
  ;; :config
  ;; (setq zenburn-override-colors-alist
  ;;       '(
  ;;         ("zenburn-bg-2"     . "#000000")
  ;;         ("zenburn-bg-1"     . "#141414")
  ;;         ("zenburn-bg-05"    . "#222222")
  ;;         ("zenburn-bg"       . "#282828")
  ;;         ("zenburn-green-25" . "#537353")
  ;;         ))
  ;; (zenburn-with-color-variables
  ;;  (set-face-attribute 'mode-line-inactive nil :foreground zenburn-green-3))
  )

(use-package circadian
  :ensure t
  :config
  (require 'cl)
  (setq calendar-latitude 43.073051
        calendar-longitude -89.401230)
  (setq circadian-themes '(("7:30" . modus-operandi)
                           ("19:30"  . zenburn)))
  ;; (set-face-attribute 'mode-line nil :box nil)
  ;; (set-face-attribute 'mode-line-inactive nil :box nil)
  ;; (set-face-attribute 'header-line nil :box nil)
  ;; (set-face-attribute 'mode-line-highlight nil :box nil)
  (add-hook 'circadian-after-load-theme-hook
            #'(lambda (theme)
                (if (eq theme 'zenburn)
                    (progn (set-face-attribute 'mode-line nil :box nil)
                           (set-face-attribute 'mode-line-inactive nil :box nil)
                           (set-face-attribute 'header-line nil :box nil)
                           (set-face-attribute 'mode-line-highlight nil :box nil)))))
  (circadian-setup)
  )

(defun xjc/circadian-day-p ()
  (let ((now (circadian-now-time)))
    (and
     (circadian-a-earlier-b-p now (circadian-sunset))
     (circadian-a-earlier-b-p (circadian-sunrise) now))))

;; ;; workaround for unspecified-fg bug
;; (add-hook 'after-make-frame-functions
;;           (lambda () (run-at-time "1 sec" nil
;;                                   (lambda () (progn (load-theme 'zenburn)
;;                                                     (set-face-attribute 'mode-line nil :box nil)
;;                                                     (set-face-attribute 'mode-line-inactive nil :box nil)
;;                                                     (set-face-attribute 'header-line nil :box nil)
;;                                                     (set-face-attribute 'mode-line-highlight nil :box nil))))))
