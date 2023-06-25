(use-package org
  :ensure t
  :bind
  ("C-c a" . org-agenda)
  ("C-c c" . org-capture)
  ("C-c l" . org-store-link)
  ("C-c o" . org-open-at-point)
  :config
  (setq org-log-done 'time)
  (setq org-default-notes-file "~/org/general.org")
  (setq org-agenda-files '("~/org"))
  (add-hook 'org-mode-hook 'turn-on-auto-fill)
  (setq org-agenda-skip-deadline-prewarning-if-scheduled 'pre-scheduled)
  (setq org-capture-templates
        '(("t" "Task" entry (file org-default-notes-file)
           "* TODO %?\n")
          ("l" "Task (with link)" entry (file org-default-notes-file)
           "* TODO %?\n%a\n")
          ("j" "Journal" entry (file+olp+datetree "~/journal.org") "* %?\n" :time-prompt t)))
  (setq org-refile-targets
        '((org-agenda-files :maxlevel . 1))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil)
  (require 'org-habit)
  (setq org-startup-indented t
        org-log-into-drawer t
        org-catch-invisible-edits 'show-and-error
        org-confirm-shell-link-not-regexp "firefox")
  (setq org-agenda-custom-commands
        '(("n" "Agenda and unplanned TODOs"
           ((agenda "")
            (search "!:-SCHEDULED -DEADLINE"))))
        )
  (setq org-file-apps
        '((auto-mode . emacs)
          ("\\.x?html?\\'" . "firefox %s")
          ("\\.pdf\\'" . "zathura \"%s\""))
        )
  :custom
  (org-list-allow-alphabetical t)
  (org-hide-leading-stars t)
  (org-extend-today-until 4)
  )

(setq initial-buffer-choice "~/organiser.org")

;; (use-package org-alert
;;   :ensure t
;;   :config
;;   (setq org-alert-interval 1800
;;         alert-default-style 'libnotify)
;;   (org-alert-enable))

(use-package org-roam
  :ensure t
  :init
  (setq org-roam-v2-ack t)
  :custom
  (org-roam-directory "~/notes")
  (org-roam-dailies-directory "journal/")
  (org-roam-completion-everywhere t)
  (org-roam-dailies-capture-templates
    '(("d" "default" entry "* %<%H:%M>\n%?"
       :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
  :bind (("C-c n l" . org-roam-buffer-toggle)
         ("C-c n f" . org-roam-node-find)
         ("C-c n i" . org-roam-node-insert)
         :map org-mode-map
         ("C-M-i" . completion-at-point)
         :map org-roam-dailies-map
         ("Y" . org-roam-dailies-capture-yesterday)
         ("T" . org-roam-dailies-capture-tomorrow)
         ("c" . org-roam-dailies-capture-date)
         ("v" . org-roam-dailies-goto-date) 
         )
  :bind-keymap
  ("C-c n d" . org-roam-dailies-map)
  :config
  (require 'org-roam-dailies)
  (org-roam-db-autosync-mode))
