(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(LaTeX-font-list
   '((83 "\\change{\\sout{" "}}")
     (115 "\\sout{" "}")
     (99 "\\change{" "}")
     (1 "" "" "\\mathcal{" "}")
     (2 "\\textbf{" "}" "\\mathbf{" "}")
     (3 "\\textsc{" "}")
     (5 "\\emph{" "}")
     (6 "\\textsf{" "}" "\\mathsf{" "}")
     (9 "\\textit{" "}" "\\mathit{" "}")
     (12 "\\textulc{" "}")
     (13 "\\textmd{" "}")
     (14 "\\textnormal{" "}" "\\mathnormal{" "}")
     (18 "\\textrm{" "}" "\\mathrm{" "}")
     (19 "\\textsl{" "}" "\\mathbb{" "}")
     (20 "\\texttt{" "}" "\\mathtt{" "}")
     (21 "\\textup{" "}")
     (23 "\\textsw{" "}")
     (4 "" "" t)))
 '(TeX-font-list
   '((22 "\\change{" "}")
     (2 "{\\bf " "}")
     (3 "{\\sc " "}")
     (5 "{\\em " "\\/}")
     (9 "{\\it " "\\/}")
     (18 "{\\rm " "}")
     (19 "{\\sl " "\\/}")
     (20 "{\\tt " "}")
     (4 "" "" t)))
 '(ansi-color-names-vector
   ["#3F3F3F" "#CC9393" "#7F9F7F" "#F0DFAF" "#8CD0D3" "#DC8CC3" "#93E0E3" "#DCDCCC"])
 '(company-quickhelp-color-background "#4F4F4F")
 '(company-quickhelp-color-foreground "#DCDCCC")
 '(custom-safe-themes
   '("fc48cc3bb3c90f7761adf65858921ba3aedba1b223755b5924398c666e78af8b" "3b8284e207ff93dfc5e5ada8b7b00a3305351a3fb222782d8033a400a48eca48" "76c5b2592c62f6b48923c00f97f74bcb7ddb741618283bdb2be35f3c0e1030e3" "42e46b9297086cde334f2de84962cb28501c165aacba387b926345e5d299cbfe" "abdb1863bc138f43c29ddb84f614b14e3819982936c43b974224641b0b6b8ba4" "9f369b75eb9e55ced90c6c6c34c9fabb2279df0bf902c1e7c4824f9c41868af4" default))
 '(fci-rule-color "#383838")
 '(ledger-reports
   '(("worth" "ledger [[ledger-mode-flags]] -f /home/xjc/ledger/main.ldg bal ^assets ^liabilities")
     ("we" "ledger [[ledger-mode-flags]] -f /home/xjc/ledger/main.ldg -W --period-sort \"-(amount)\" reg ^expenses --real -b \"last month\" --start-of-week=1")
     ("me" "ledger [[ledger-mode-flags]] -f /home/xjc/ledger/main.ldg -M --period-sort \"-(amount)\" reg ^expenses --real -b \"last month\"")
     ("mr" "%(binary) -f /home/xjc/ledger/main.ldg --sort \"-(amount)\" --real -b \"this month\" reg ^expenses")
     ("fb" "%(binary) -f /home/xjc/ledger/main.ldg bal ^funds")
     ("bal" "%(binary) -f %(ledger-file) bal")
     ("reg" "%(binary) -f %(ledger-file) reg")
     ("payee" "%(binary) -f %(ledger-file) reg @%(payee)")
     ("account" "%(binary) -f %(ledger-file) reg %(account)")))
 '(lsp-julia-default-environment "~/.julia/environments/v1.4")
 '(lsp-julia-package-dir nil)
 '(nrepl-message-colors
   '("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3"))
 '(package-selected-packages
   '(org-roam pollen-mode racket-mode svg-tag-mode modus-themes lsp-java python-x poly-R poly-r tango-plus-theme ivy-prescient company-prescient ivy-xref company-anaconda pdfgrep ivy-bibtex wolfram-mode lispy zoutline iedit Ipy lpy emojify labburn-theme interleave org-ref eyebrowse auto-yasnippet circadian dumb-jump ess leim sage-shell-mode smartparens lsp-julia lsp-ivy julia-mode speed-type prism quelpa-use-package lsp-ui octave-mode zenburn-theme paper-theme company-lsp lsp-mode flycheck-julia julia-repl oer-reveal poly-markdown which-key dired-open multiple-cursors expand-region messages-are-flowing org-alert rainbow-delimiters yaml-mode anaconda-mode nov ledger-mode flycheck-ledger flycheck dired-narrow dired-x dired-du diminish zzz-to-char company spray whitespace-cleanup-mode ace-link golden-ratio projectile counsel yasnippet elfeed ace-window edit-indirect csv-mode markdown-mode magit auto-complete auctex use-package pdf-tools magit-popup bind-key ace-jump-mode))
 '(rainbow-identifiers-choose-face-function 'rainbow-identifiers-cie-l*a*b*-choose-face)
 '(rainbow-identifiers-cie-l*a*b*-color-count 1024)
 '(rainbow-identifiers-cie-l*a*b*-lightness 80)
 '(rainbow-identifiers-cie-l*a*b*-saturation 25)
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   '((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3")))
 '(vc-annotate-very-old-color "#DC8CC3")
 '(warning-suppress-types '((comp))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

