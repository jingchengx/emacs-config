(set-fill-column 79)

;; prog-mode hooks
(dolist (mode '(show-paren-mode
                whitespace-cleanup-mode
                company-mode
                ;; whitespace-mode
                ;; auto-fill-mode
                ))
  (add-hook 'prog-mode-hook mode)
  (add-hook 'ledger-mode-hook mode))

(use-package whitespace
  :diminish
  :custom
  (whitespace-style '(face lines-tail)))

(use-package smartparens :ensure
  :bind (:map smartparens-mode-map
              ("M-[" . sp-backward-unwrap-sexp)
              ("M-]" . sp-unwrap-sexp)
              ("C-M-f" . sp-forward-sexp)
              ("C-M-b" . sp-backward-sexp)
              ("C-M-t" . sp-transpose-sexp)
              ("C-M-k" . sp-kill-sexp)
              ("C-<right>" . sp-forward-slurp-sexp)
              ("M-<right>" . sp-forward-barf-sexp)
              ("C-<left>"  . sp-backward-slurp-sexp)
              ("M-<left>"  . sp-backward-barf-sexp))
  :config
  (require 'smartparens-config)
  )

(use-package flycheck
  :ensure t
  :init
  :config
  (setq flycheck-lintr-linters
        "with_defaults(assignment_linter = NULL, infix_spaces_linter = NULL)")
  :hook (prog-mode . flycheck-mode))

(use-package ivy-xref
  :ensure t
  :init
  ;; xref initialization is different in Emacs 27 - there are two different
  ;; variables which can be set rather than just one
  (when (>= emacs-major-version 27)
    (setq xref-show-definitions-function #'ivy-xref-show-defs))
  ;; Necessary in Emacs <27. In Emacs 27 it will affect all xref-based
  ;; commands other than xref-find-definitions (e.g. project-find-regexp)
  ;; as well
  (setq xref-show-xrefs-function #'ivy-xref-show-xrefs))

(use-package dumb-jump
  ;; :bind (("M-g o" . dumb-jump-go-other-window)
  ;;        ("M-g j" . dumb-jump-go)
  ;;        ("M-g i" . dumb-jump-go-prompt)
  ;;        ("M-g l" . dumb-jump-back)
  ;;        ("M-g h" . dumb-jump-quick-look))
  :config
  (setq dumb-jump-selector 'ivy
                dumb-jump-aggressive t)
  (add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
  :ensure)

(use-package lispy :ensure)

(use-package python
  ;; :config
  ;; (defun xjc/python-shell-send-region (&optional beg end)
  ;;   (interactive)
  ;;   (let ((beg (cond (beg beg)
  ;;                    ((region-active-p)
  ;;                     (region-beginning))
  ;;                    (t (line-beginning-position))))
  ;;         (end (cond (end end)
  ;;                    ((region-active-p)
  ;;                     (copy-marker (region-end)))
  ;;                    (t (line-end-position)))))
  ;;     (python-shell-send-region beg end)
  ;;     (unless (region-active-p)
  ;;       (next-line))))
  ;; :bind (:map python-mode-map
  ;;             ;; (("C-<return>" . (lambda (arg) (interactive "p")
  ;;             ;;                    (lispy-eval arg)
  ;;             ;;                    (lpy-down arg)))
  ;;             ;;  ("C-c C-z" . lpy-switch-to-shell))
  ;;             (("C-<return>" . xjc/python-shell-send-region)
  ;;              ("C-c C-y" . lpy-mode))
  ;;             )
  )

(use-package python-x :ensure
  :config
  (python-x-setup)
  (setq python-section-delimiter "##")
  :bind
  (:map python-mode-map
        (("C-<return>" . python-shell-send-line-and-step)))
)

;; (use-package lpy
;;   :quelpa (lpy :fetcher github :repo "abo-abo/lpy"))

(use-package anaconda-mode
  :ensure t
  :hook ((python-mode . anaconda-mode)
         (python-mode . anaconda-eldoc-mode)))

(use-package company-anaconda :ensure t
  :config
  (push 'company-anaconda company-backends))

(use-package julia-mode :ensure t
  :mode "\\.jl\\'"
  :config
  (advice-add 'julia-repl
              :after (function
                      (lambda ()
                        (set-buffer-process-coding-system
                         'utf-8-unix 'utf-8-unix))))
  (add-hook 'julia-mode-hook 'flycheck-mode)
  :custom
  (julia-repl-switches "--color=no")
  )

(add-hook 'term-mode-hook (lambda () (define-key term-raw-map (kbd "M-o") 'nil)))

(use-package julia-repl :ensure t
  :hook (julia-mode . julia-repl-mode))

(use-package rainbow-delimiters :ensure t
  :hook (prog-mode . rainbow-delimiters-mode))

(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
        try-expand-list
        try-complete-file-name-partially
        try-complete-lisp-symbol-partially
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-all-abbrevs
        try-complete-file-name
        try-expand-line
        try-complete-lisp-symbol))

(use-package lsp-mode :ensure t
  ;; :hook (julia-mode . lsp)
  :bind (:map lsp-mode-map
              ("M-?" . lsp-find-references)
              ("M-." . lsp-find-definition)
              ("M-\"" . lsp-describe-thing-at-point))
  :commands lsp
  :config
  (setq lsp-eldoc-render-all nil)
  ;; (setq lsp-auto-configure nil)
  (defun ff/lsp-eldoc-advice (orig-fun &rest args)
    (let ((msg (car args)))
      (if msg
          (funcall orig-fun (->> msg (s-trim-left)
                                     (s-split "\n")
                                     (first))))))
  (advice-add 'lsp--eldoc-message :around #'ff/lsp-eldoc-advice))

(use-package lsp-ui :ensure t
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-sideline-enable nil)
  (lsp-ui-doc-enable nil))

;; (use-package lsp-julia
;;   :quelpa (lsp-julia :fetcher github :repo "non-Jedi/lsp-julia")
;;   :custom
;;   (lsp-julia-package-dir nil)
;;   (lsp-julia-default-environment "~/.julia/environments/v1.5"))

(use-package company-lsp :ensure t
  :if (eq system-type 'gnu/linux)
  :config
  (push 'company-lsp company-backends))

(use-package projectile :ensure t
  :bind-keymap
  ("C-x p" . projectile-command-map)
  :config
  (setq projectile-completion-system 'ivy))

(use-package sage-shell-mode :ensure
  ;; :config
  ;; (add-hook 'sage-shell-mode-hook #'eldoc-mode)
  ;; (add-hook 'sage-shell-mode-hook #'eldoc-mode)
  ;; (add-hook 'sage-shell:sage-mode-hook (lambda () (setq comint-process-echoes t)))
  )

(use-package octave
  ;; :mode ("\\.m\\'" . octave-mode)
  :bind
  (:map octave-mode-map
        ("C-c C-z" . inferior-octave)))

(use-package ess
  :ensure t
  :config
  (setq ess-use-ido nil
        ess-eval-visibly 'nowait))

;; (use-package lsp-java :ensure
;;   :config
;;   (add-hook 'java-mode-hook #'lsp)
;;   )

(use-package racket-mode :ensure t)

(require 're-builder)
(setq reb-re-syntax 'string)
