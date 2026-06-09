(use-package org
  :custom
  (org-confirm-babel-evaluate nil)
  (org-startup-indented t)
  (org-src-tab-acts-natively t)
  (org-edit-src-content-indentation 0)
  (org-hide-emphasis-markers t)
  (org-hide-leading-stars t)
  (org-pretty-entities nil)
  (org-startup-with-inline-images t)
  (org-id-link-to-org-use-id t)
  (org-agenda-files '("~/notes"))
  :config
  (custom-theme-set-faces
   'user
   `(line-number ((t (:inherit 'fixed-pitch))))
   `(org-level-1 ((t (:foreground "black" :distant-foreground "gainsboro" :family "Junicode" :height 1.75 :weight semi-bold))))
   `(org-level-2 ((t (:foreground "black" :distant-foreground "gainsboro" :family "Junicode" :height 1.5 :weight semi-bold))))
   `(org-level-3 ((t (:foreground "black" :distant-foreground "gainsboro" :family "Junicode" :height 1.25 :weight semi-bold))))
   `(org-level-4 ((t (:foreground "black" :distant-foreground "gainsboro" :family "Junicode" :height 1.1 :weight semi-bold))))
   `(org-block-begin-line ((t (:inherit org-meta-line :overline t))))
   `(org-block-end-line ((t (:inherit org-meta-line :underline t))))
   `(org-block ((t (:height 0.75))))
   `(org-table ((t (:height 0.75))))
   `(org-verbatim ((t (:height 0.75))))
   `(org-code ((t (:height 0.75))))
   `(org-meta-line ((t (:height 0.75))))
   )
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (calc . t)
     (haskell . t)
     (python . t)
     (shell . t)
     ;;(jupyter . t)
     ))
  (add-hook 'org-babel-after-execute-hook 'org-redisplay-inline-images 'append)
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook (lambda () (setq-local
                                       left-margin-width 4
                                       right-margin-width 4))))

(use-package org-appear
  :hook (org-mode . org-appear-mode))

(use-package org-variable-pitch
  :config
  (add-hook 'after-init-hook #'org-variable-pitch-setup))

(use-package org-bullets
  :custom
  (org-ellipsis "⤵")
  (org-bullets-bullet-list '("§" "◉" "○" "●"))
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

(use-package org-ql)

(use-package org-sidebar)

(use-package org-journal)

(use-package org-super-links
  :vc (:url "https://github.com/toshism/org-super-links.git" :rev :newest))

(use-package org-transclusion
  :after org)

(use-package org-transclusion-http
  :after org-transclusion
  :config
  (add-to-list 'org-transclusion-extensions 'org-transclusion-http))

(use-package deft
  :custom
  (deft-directory "~/notes")
  (deft-recursive t))
