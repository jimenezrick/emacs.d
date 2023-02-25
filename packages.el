(use-package quelpa-use-package
  :custom
  (quelpa-update-melpa-p nil))

(use-package helm
  :disabled
  :custom
  (helm-M-x-fuzzy-match t)
  (helm-buffers-fuzzy-matching t)
  (helm-recentf-fuzzy-match t)
  (helm-etags-fuzzy-match t)
  (helm-split-window-in-side-p t)
  :config
  (helm-mode)
  (helm-autoresize-mode)
  :bind (("M-x" . helm-M-x)
         ("C-c y" . helm-show-kill-ring)
         ("C-c j" . helm-all-mark-rings)
         ("C-c t" . helm-imenu-in-all-buffers)
         ("C-c T" . imenu-list-smart-toggle)
         ("C-x C-f" . helm-find-files)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action)
         ("C-z" . helm-select-action)))

(use-package helm-xref)

(use-package helm-git-grep
  :bind (("C-c ." . helm-git-grep-at-point)
         ("C-c g" . helm-git-grep)
         :map c-mode-base-map
         ("C-c ." . nil)))

(use-package helm-ls-git)

(use-package evil
  :custom
  (evil-want-keybinding nil)
  (evil-want-C-u-scroll t)
  (evil-want-fine-undo t)
  :config
  (evil-mode)
  (evil-set-undo-system 'undo-tree)

  (define-key evil-insert-state-map (kbd "C-k") 'comment-indent-new-line)
  (define-key evil-normal-state-map (kbd "C-j") (lambda () (interactive) (evil-next-line 6)))
  (define-key evil-normal-state-map (kbd "C-k") (lambda () (interactive) (evil-previous-line 6)))
  (define-key evil-normal-state-map (kbd "s") 'ace-jump-mode)
  (define-key evil-insert-state-map (kbd "C-j") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-x C-o") 'company-complete)
  (define-key evil-insert-state-map (kbd "C-x C-f") 'company-files)
  (define-key evil-normal-state-map (kbd "C-p") 'fzf-git-files)
  (define-key evil-normal-state-map (kbd "C-c SPC") 'tab-switch)
  (define-key evil-normal-state-map (kbd "SPC") 'switch-to-buffer)
  (define-key evil-normal-state-map (kbd "M-.") 'xref-find-definitions)

  (define-key evil-normal-state-map (kbd "C-w C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-w C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-w C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-w C-j") 'evil-window-down)
  (define-key evil-normal-state-map (kbd "C-w f") 'make-frame)
  (define-key evil-normal-state-map (kbd "C-w t") 'tab-new)
  (define-key evil-normal-state-map (kbd "S-<prior>") 'tab-previous)
  (define-key evil-normal-state-map (kbd "S-<next>") 'tab-next)

  (add-to-list 'evil-insert-state-modes 'git-commit-mode))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-numbers
  :config
  (define-key evil-normal-state-map (kbd "C-c C-=") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-c C--") 'evil-numbers/dec-at-pt))

(use-package evil-nerd-commenter
  :config
  (evilnc-default-hotkeys))

(use-package ggtags
  :config
  (add-hook 'text-mode-hook #'ggtags-mode)
  (add-hook 'prog-mode-hook #'ggtags-mode))

(use-package treemacs
  :custom
  (treemacs-missing-project-action 'remove)
  (treemacs-recenter-after-file-follow t)
  (treemacs-follow-mode t)
  (treemacs-default-visit-action 'treemacs-visit-node-in-most-recently-used-window)
  :config
  (with-eval-after-load 'treemacs
    (define-key treemacs-mode-map [mouse-1] #'treemacs-single-click-expand-action)))

(use-package treemacs-evil)
(use-package treemacs-projectile)
(use-package treemacs-magit)
(use-package treemacs-all-the-icons
  :if window-system
  :config
  (treemacs-load-theme 'all-the-icons))

(use-package dashboard
  :custom
  (dashboard-startup-banner 'logo)
  (dashboard-banner-logo-title nil)
  (dashboard-set-init-info nil)
  (dashboard-set-footer nil)
  (dashboard-items '((recents . 15)
                     (projects . 10)
                     (bookmarks . 5)
                     (registers . 5)))
  :init
  (if (< (length command-line-args) 2)
      (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))
  :config
  (dashboard-setup-startup-hook))

(use-package project
  ;; Cannot use :hook because 'project-find-functions does not end in -hook,
  ;; cannot use :init (must use :config) because otherwise
  ;; project-find-functions is not yet initialized.
  :config
  (add-hook 'project-find-functions #'my-project-override))

(use-package projectile
  :config
  (projectile-mode))

(use-package helm-projectile
  :custom
  (helm-mini-default-sources '(helm-source-projectile-buffers-list
                               helm-source-buffers-list
                               helm-source-projectile-recentf-list
                               helm-source-recentf
                               helm-source-projectile-projects
                               helm-source-buffer-not-found))
  :config
  (helm-projectile-on))

(use-package recentf
  :config
  (recentf-mode))

(use-package minimap)

(use-package fzf)

(use-package magit)

(use-package flycheck
  :config
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package company
  :custom
  (company-begin-commands '(self-insert-command))
  (company-require-match nil)
  (company-idle-delay .1)
  (company-minimum-prefix-length 2)
  (company-tooltip-limit 20)
  (company-tooltip-align-annotations t)
  (company-echo-delay 0)
  (company-selection-wrap-around t)
  (company-dabbrev-downcase nil)
  (company-dabbrev-ignore-case nil)
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  :bind (:map company-active-map
              ([tab] . company-complete-common-or-cycle)
              ("C-f" . company-filter-candidates)
              ("C-p" . company-select-previous)
              ("C-n" . company-select-next)))

(use-package company-box
  :if window-system
  :hook (company-mode . company-box-mode))

(use-package company-quickhelp
  :config
  (company-quickhelp-mode))

(use-package company-quickhelp-terminal
  :if (not window-system)
  :custom
  (company-quickhelp-use-propertized-text nil)
  :config
  (with-eval-after-load 'company-quickhelp
    (company-quickhelp-terminal-mode 1)))

(use-package ace-jump-mode)

(use-package rainbow-delimiters
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package idle-highlight-mode
  :config
  (add-hook 'prog-mode-hook #'idle-highlight-mode))

(use-package hl-todo
  :config
  (add-hook 'prog-mode-hook #'hl-todo-mode))

(use-package whitespace
  :custom
  (whitespace-style '(face tabs tab-mark trailing))
  (whitespace-display-mappings
   '((space-mark  ?\   [?·])
     (tab-mark    ?\t  [?| ?\t])))
  :config
  (add-hook 'text-mode-hook #'whitespace-mode)
  (add-hook 'prog-mode-hook #'whitespace-mode))

(use-package which-key
  :config
  (which-key-mode)
  (which-key-setup-side-window-right))

(use-package yaml-mode
  :mode
  (("\\.sls\\'" . yaml-mode)))

(use-package protobuf-mode)

(use-package goto-chg)

(use-package undo-tree
  :custom
  (undo-tree-visualizer-diff t)
  (undo-tree-visualizer-timestamps t)
  :config
  (global-undo-tree-mode))

(use-package flyspell-popup
  :config
  (add-hook 'flyspell-mode-hook #'flyspell-popup-auto-correct-mode))

(use-package markdown-mode
  :commands
  (markdown-mode gfm-mode)
  :mode
  (("README\\.md\\'" . gfm-mode)
   ("\\.md\\'" . markdown-mode)
   ("\\.markdown\\'" . markdown-mode))
  :custom
  (markdown-command "pandoc")
  (markdown-hide-markup t))

(use-package pandoc-mode
  :config
  (add-hook 'markdown-mode-hook #'pandoc-mode))

(use-package org
  :custom
  (org-confirm-babel-evaluate nil)
  (org-startup-indented t)
  (org-src-tab-acts-natively t)
  (org-hide-emphasis-markers t)
  (org-hide-leading-stars t)
  (org-pretty-entities t)
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
   `(org-block-begin-line ((t (:height 0.75))))
   `(org-block-end-line ((t (:height 0.75))))
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
     (shell . t)
     (jupyter . t)))
  (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook (lambda () (setq-local
                                       left-margin-width 4
                                       right-margin-width 4))))

(use-package org-variable-pitch
  :config
  (add-hook 'after-init-hook #'org-variable-pitch-setup))

(use-package org-bullets
  :custom
  (org-ellipsis "⤵")
  (org-bullets-bullet-list '("◉" "○" "●" "◈" "◇" "◆"))
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

(use-package org-ql)

(use-package helm-org-ql)

(use-package org-sidebar)

(use-package org-journal)

(use-package org-super-links
  :quelpa (org-super-links :repo "toshism/org-super-links" :fetcher github :commit "develop"))

(use-package deft
  :custom
  (deft-directory "~/notes")
  (deft-recursive t))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK"))

(use-package highlight-indent-guides
  :custom
  (highlight-indent-guides-method 'column)
  (highlight-indent-guides-responsive 'top)
  :config
  (add-hook 'prog-mode-hook 'highlight-indent-guides-mode))

(use-package elfeed
  :custom
  (elfeed-feeds '(("https://elpais.com/rss/elpais/portada.xml" EP news es)
                  ("https://www.telegraph.co.uk/rss.xml" TLG news uk)
                  ("https://www.ft.com/?format=rss" FT fin)
                  ("https://www.reddit.com/domain/bloomberg.com.rss" BBG fin)
                  ("https://feeds.feedburner.com/zerohedge/feed?format=xml" ZH fin)))
  (elfeed-search-filter "@2-days-ago +news"))

(use-package pos-tip
  :config
  (defun show-command-region-in-popup ()
    (interactive)
    (if (use-region-p)
        (pos-tip-show
         (shell-command-to-string
          (buffer-substring-no-properties (region-beginning) (region-end))))
      (message "No active region")))
  (defun describe-thing-in-popup ()
    (interactive)
    (let* ((thing (symbol-at-point))
           (help-xref-following t)
           (description (with-temp-buffer
                          (help-mode)
                          (describe-symbol thing)
                          (buffer-string))))
      (pos-tip-show description)))
  (defun my-elisp-setup ()
    (define-key evil-normal-state-map (kbd "C-;") (lambda () (interactive) (describe-thing-in-popup))))
  (add-hook 'emacs-lisp-mode-hook 'my-elisp-setup)
  (define-key evil-normal-state-map (kbd "C-'") (lambda () (interactive) (show-command-region-in-popup))))

(use-package eglot
  :custom
  (eglot-events-buffer-size 0)
  :config
  (add-to-list 'eglot-server-programs '(rust-mode . ("rust-analyzer")))
  (add-hook 'eglot-managed-mode-hook (lambda () (flymake-mode -1))))

(use-package vterm)

(use-package imenu-list
  :custom
  (imenu-list-auto-resize nil)
  (imenu-list-size 40))

(use-package tab-bar-echo-area
  :config
  (tab-bar-echo-area-mode 1))

(use-package svg-tag-mode
  :custom
  (svg-tag-tags
   '((":TODO:" . ((lambda (tag) (svg-tag-make "TODO"))))))
  :hook (org-mode text-mode))

(use-package jupyter
  :disabled)

(use-package gpt
  :custom
  (gpt-openai-engine "code-davinci-002")
  :config
  (setq gpt-openai-key (getenv "GPT_OPENAI_KEY")))

(use-package codegpt
  :config
  (setq openai-key (getenv "GPT_OPENAI_KEY")))

(use-package tree-sitter
  :config
  (global-tree-sitter-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package tree-sitter-langs
  :quelpa (tree-sitter-langs :repo "emacs-tree-sitter/tree-sitter-langs" :fetcher github :commit "master"))

(use-package helm-tree-sitter)

(use-package ts-fold
  :config
  (add-hook 'tree-sitter-after-on-hook #'ts-fold-indicators-mode))

(use-package flycheck-languagetool
  :disabled
  ;; The service needs to be started first with:
  ;; systemctl start languagetool.service
  :custom
  (flycheck-languagetool-server-jar "/usr/share/java/languagetool/languagetool-server.jar")
  :hook (text-mode . flycheck-languagetool-setup))

(use-package reformatter)

(use-package yasnippet
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(use-package yasnippet-snippets)
