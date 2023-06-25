(use-package dired-x
  :bind ("C-x C-d" . dired-jump)
  :config
  (setq dired-omit-files
        (concat dired-omit-files "\\|^\\..+$"))
  (setq dired-guess-shell-alist-user '(
                                       ("\\.pdf\\'" "zathura")
                                       ("\\.djvu\\'" "zathura")
                                       ("\\.mp4\\'" "mpv")
                                       ("\\.aac\\'" "mpv --player-operation-mode=pseudo-gui")
                                       ("\\.mov\\'" "mpv")
                                       ("\\.mkv\\'" "mpv")
                                       ("\\.avi\\'" "mpv")
                                       ("\\.wmv\\'" "mpv")
                                       ("\\.html\\'" "firefox")
                                       ("\\.docx\\'" "abiword")
                                       ;; ("\\.jpe?g\\'" "imv-wayland")
                                       ;; ("\\.png\\'" "imv-wayland")
                                       )))

(setq dired-dwim-target t)

(use-package dired-du
  :ensure t)
(setq dired-isearch-filenames 'dwim
      dired-listing-switches "-alh")

(use-package dired-narrow
  :ensure t
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))

(use-package dired-open
  :if (eq system-type 'gnu/linux)
  :config
  (setq dired-open-functions '(dired-open-guess-shell-alist dired-open-by-extension dired-open-subdir)))

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)
