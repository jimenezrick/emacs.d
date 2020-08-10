(use-package helm
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
         ("C-x C-f" . helm-find-files)
         :map helm-map
         ("<tab>" . helm-execute-persistent-action)
         ("<backtab>" . helm-select-action)))

(use-package helm-xref)

(use-package helm-git-grep
  :bind (("C-c ." . helm-git-grep-at-point)
         ("C-c g" . helm-git-grep)))

(use-package helm-ls-git)

(use-package evil
  :custom
  (evil-want-C-u-scroll t)
  (evil-want-fine-undo t)
  :config
  (evil-mode)

  (define-key evil-insert-state-map (kbd "C-k") 'comment-indent-new-line)
  (define-key evil-normal-state-map (kbd "C-j") (lambda () (interactive) (evil-next-line 6)))
  (define-key evil-normal-state-map (kbd "C-k") (lambda () (interactive) (evil-previous-line 6)))
  (define-key evil-normal-state-map (kbd "s") 'ace-jump-mode)
  (define-key evil-insert-state-map (kbd "C-j") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-x C-o") 'company-complete)
  (define-key evil-insert-state-map (kbd "C-x C-f") 'company-files)
  (define-key evil-normal-state-map (kbd "C-p") 'fzf-git-files)
  (define-key evil-normal-state-map (kbd "SPC") 'helm-mini)
  (define-key evil-normal-state-map (kbd "M-.") 'xref-find-definitions)

  (define-key evil-normal-state-map (kbd "C-w C-h") 'evil-window-left)
  (define-key evil-normal-state-map (kbd "C-w C-l") 'evil-window-right)
  (define-key evil-normal-state-map (kbd "C-w C-k") 'evil-window-up)
  (define-key evil-normal-state-map (kbd "C-w C-j") 'evil-window-down)

  (add-to-list 'evil-insert-state-modes 'git-commit-mode))

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
  (treemacs-no-png-images t)
  (treemacs-missing-project-action 'remove)
  (treemacs-recenter-after-file-follow t)
  (treemacs-recenter-after-tag-follow t)
  (treemacs-tag-follow-mode t))

(use-package treemacs-evil)
(use-package treemacs-projectile)
(use-package treemacs-magit)

(use-package dashboard
  :custom
  (dashboard-startup-banner 'logo)
  (dashboard-banner-logo-title nil)
  (dashboard-set-init-info nil)
  (dashboard-set-footer nil)
  (dashboard-items '((recents . 10)
                     (bookmarks . 5)
                     (projects . 5)
                     (registers . 5)))
  :init
  (if (< (length command-line-args) 2)
      (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))
  :config
  (dashboard-setup-startup-hook))

(use-package projectile
  :config
  (projectile-mode))

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

(use-package company-quickhelp
  :config
  (company-quickhelp-mode))

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
  :config
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((emacs-lisp . t)
     (shell . t))))

(use-package org-bullets
  :custom
  (org-ellipsis "⤵")
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

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
  (elfeed-feeds '(("https://news.ycombinator.com/rss" HN tech)
                  ("https://lwn.net/headlines/rss" LWN tech)
                  ("https://elpais.com/rss/elpais/portada.xml" EP news es)
                  ("https://rss.elconfidencial.com" EC news es)
                  ("https://www.eldiario.es/rss" ED news es)
                  ("http://feeds.bbci.co.uk/news/rss.xml" BBC news uk)
                  ("https://www.telegraph.co.uk/rss.xml" TLG news uk)
                  ("https://www.ft.com/?format=rss" FT fin)
                  ("https://www.reddit.com/domain/bloomberg.com.rss" BBG fin)
                  ("https://feeds.feedburner.com/zerohedge/feed?format=xml" ZH fin)))
  (elfeed-search-filter "@2-days-ago +news"))
