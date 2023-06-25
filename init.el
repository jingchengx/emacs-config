;; (add-to-list 'default-frame-alist '(alpha . (98 . 98)))

(setq undo-limit 1000000)
(setq undo-strong-limit (* 10 undo-limit))
(setq undo-outer-limit (* 20 undo-limit))

(setq-default indent-tabs-mode nil)     ; always indent with whitespace
(setq kill-read-only-ok t)

(setq calendar-week-start-day 1)
;; Time and battery in mode line
(setq display-time-24hr-format t)
(display-time-mode)
(display-battery-mode)
(setq battery-mode-line-format " [%p%%]"
      battery-mode-line-limit 50
      display-time-load-average-threshold 0.5)

(setq ispell-dictionary "en_GB-ize-w_accents")

;; Misc configurations
(setq tramp-default-method "ssh")
(setq python-shell-interpreter "/usr/bin/python3")
(setq browse-url-browser-function 'browse-url-chrome)
;; (setq browse-url-browser-function 'browse-url-default-browser)
(setq browse-url-chromium-arguments '("--force-device-scale-factor=1.2"))

(setq use-short-answers t)
(setq next-error-message-highlight t)

;; avoid accidentally suspend frame
(global-unset-key (kbd "C-z"))

;; Custom bindings
(setq disabled-command-function nil)
(global-set-key "\M-/" 'hippie-expand)
(global-set-key (kbd "M-i") 'imenu)
(global-unset-key (kbd "C-x C-z"))

;; tab-bar-mode
(setq tab-bar-show nil)

;; winner-mode
;; (winner-mode)
;; (global-set-key [f7] 'winner-undo)
;; (global-set-key [C-f7] 'winner-redo)

;; Package configs
(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives
      '(
	("GNU ELPA"     . "http://elpa.gnu.org/packages/")
        ("MELPA Stable" . "https://stable.melpa.org/packages/")
        ("MELPA"        . "https://melpa.org/packages/")
	;; ("GNU ELPA"     . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
	;; ("MELPA Stable" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa-stable")
	;; ("MELPA"        . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
        )
      package-archive-priorities
      '(("MELPA Stable" . 0)
        ("GNU ELPA"     . 5)
        ("MELPA"        . 10)))
(package-initialize)

;; Bootstrap `use-package`
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
;; (quelpa
;;  '(quelpa-use-package
;;    :fetcher git
;;    :url "https://github.com/quelpa/quelpa-use-package.git"))
;; (require 'quelpa-use-package)

;; (add-hook 'mu4e-view-mode-hook 'xjc/larger-font)
;; (add-hook 'mu4e-headers-mode-hook 'xjc/larger-font)

;; Minimal UI
(setq inhibit-startup-screen t)
(scroll-bar-mode -1)
(tool-bar-mode   -1)
(tooltip-mode    -1)
(menu-bar-mode   -1)
(blink-cursor-mode -1)
(fringe-mode 2)
(setq ring-bell-function 'ignore)
(setq scroll-preserve-screen-position t)
(set-face-attribute 'default nil
                    ;; :family "IBM Plex Mono"
                    ;; :height 130         ;handled in monitors.el
                    :weight 'normal
                    :width 'normal)
(set-face-attribute 'fringe nil)


(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(defun load-user-file (file)
  (load-file (locate-user-emacs-file file)))


(load-user-file "dired.el")
(load-user-file "org-mode.el")
(load-user-file "prog.el")
(load-user-file "theme.el")


;; ;; OS specific
;; (cond ((eq system-type 'darwin)
;;        (setq mac-command-modifier 'meta)
;;        (setq mac-option-modifier 'control)
;;        (setq mac-control-modifier 'super)
;;        )
;;       ((eq system-type 'gnu/linux)
;;        (add-to-list 'default-frame-alist '(undecorated . t))
;;        (load-user-file "mail.el")
;;        (load-user-file "ledger.el")
;;        (load-user-file "monitors.el")
;;        ;; (load-user-file "elfeed.el")
;;        (load-user-file "pdf-tools.el")
;;        ))



(use-package ibuffer
  :bind
  (("C-x C-b" . ibuffer)
   :map ibuffer-mode-map
   ("M-o" . nil)))

(use-package rainbow-delimiters
  :ensure t)

(use-package counsel
  :demand
  :ensure t)

(use-package ivy
  :demand
  :ensure t
  :diminish ivy-mode
  :bind
  ("C-x C-f" . counsel-find-file)
  ("<f6>" . ivy-resume)
  ("C-x l" . counsel-locate)
  ("M-y" . counsel-yank-pop)
  ("C-x b" . counsel-switch-buffer)
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t
        ivy-count-format "%d/%d "
        enable-recursive-minibuffers t
        ivy-wrap t
        ivy-height 7)
  (setq ivy-re-builders-alist
        '((read-file-name-internal . ivy--regex-ignore-order)
          (internal-complete-buffer . ivy--regex-ignore-order)
          (ivy-bibtex . (lambda (str)
                          (let ((ivy-re-builders-alist '((t . ivy--regex-ignore-order))))
                            (swiper--re-builder str)))) ; so that char-fold is in effect
          (t . ivy--regex-ignore-order)))
  (setq ivy-sort-matches-functions-alist
        '((t . ivy-sort-function-buffer)
          (ivy-switch-buffer . ivy-sort-function-buffer)
          (counsel-find-file . ivy-sort-function-buffer)))
  (setq ivy-initial-inputs-alist
        '((counsel-minor . "^+")
          (counsel-package . "^+")
          (counsel-M-x . "^")
          (counsel-describe-function . "^")
          (counsel-describe-variable . "^")
          (counsel-org-capture . "^")
          (Man-completion-table . "^")
          (woman . "^")))
  (setq search-default-mode #'char-fold-to-regexp)
  )

(use-package prescient :ensure)

(use-package ivy-prescient :ensure
  :after counsel
  :config
  (ivy-prescient-mode 1))

(use-package company-prescient :ensure
  :after company
  :config
  (company-prescient-mode 1))

(use-package recentf
  :init
  (recentf-mode t)
  (setq recentf-max-saved-items 5000)
  :bind
  ("C-x f" . counsel-recentf)
  :hook (server-done . recentf-save-list)
  :config
  (add-hook 'delete-frame-functions (lambda (frame) (recentf-save-list)))
  )

(use-package saveplace
  :init
  (save-place-mode t))

(use-package diminish
  :demand
  :ensure t
  :config
  (diminish 'auto-revert-mode))

(use-package ace-link
  :ensure t
  :config
  (ace-link-setup-default))

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)
  :custom
  (magit-diff-refine-hunk t))

(use-package company
  :diminish company-mode
  :ensure t
  :config
  (setq company-idle-delay 0.2))

(use-package whitespace-cleanup-mode
  :ensure t
  :diminish whitespace-cleanup-mode)

(use-package ace-window
  :ensure t
  :bind
  ("M-o" . ace-window)
  :config
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  (setq aw-background nil
        aw-scope 'frame))

(use-package yaml-mode
  :ensure t
  :mode "\\.yaml\\'")

(use-package yasnippet
  :demand
  :ensure t
  :config
  (yas-reload-all)
  :hook ((prog-mode ledger-mode) . yas-minor-mode))

(use-package auto-yasnippet
  :ensure t
  :bind
  ("s-w" . aya-create)
  ("s-y" . aya-expand)
  ("C-o" . aya-open-line))

(use-package expand-region
  :ensure t
  :bind
  ("C-=" . er/expand-region))

(use-package multiple-cursors
  :ensure t
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-c C-<" . mc/mark-all-like-this)))

(use-package which-key :ensure t
  :diminish which-key-mode
  :config
  (which-key-mode))

;; (use-package eyebrowse :ensure t
;;   :config (eyebrowse-mode t))

(use-package undo-tree :ensure t)

;; (use-package lentic
;;   :ensure t
;;   :config
;;   (global-lentic-mode))

;; (use-package nov
;;   :ensure t
;;   :mode ("\\.epub\\'" . nov-mode))

;; ;; Tramp
;; (use-package exec-path-from-shell
;;   :ensure t
;;   :config
;;   (when (memq window-system '(mac ns x))
;;     (exec-path-from-shell-initialize)))

(use-package csv-mode
  :ensure t
  :mode "\\.csv\\'")

;; (use-package exwm
;;   :config
;;   (require 'exwm-config)
;;   (exwm-config-default))

(setq backup-by-copying-when-linked t)

;; (use-package svg-tag-mode
;;   :config
;;   (setq svg-tag-tags
;;         '(("TODO:" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo :inverse t))))
;;           ("FIXME:" . ((lambda (tag) (svg-tag-make "FIXME" :face 'org-todo :inverse t)))))))

(use-package hl-todo :ensure t
  :hook (LaTeX-mode . hl-todo-mode)
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("DISC"       warning bold)
          ("HOLD"       warning bold)
          ("FIXME"      error bold))))
