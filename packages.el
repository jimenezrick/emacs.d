(use-package evil
  :custom
  (evil-symbol-word-search t)
  (evil-want-C-u-scroll t)
  (evil-want-fine-undo t)
  :init
  (setq evil-want-keybinding nil)
  :config
  (evil-mode)
  (evil-set-undo-system 'undo-redo) ; Use native redo function
  (add-to-list 'evil-insert-state-modes 'git-commit-mode)
  :bind (:map evil-insert-state-map
              ("C-k" . 'comment-indent-new-line)
              ("C-j" . 'evil-normal-state)
              ("C-x C-o" . 'company-complete)
              ("C-x C-f" . 'company-files)
         :map evil-normal-state-map
              ("C-." . nil)

              ("C-j" . (lambda () (interactive) (evil-next-line 6)))
              ("C-k" . (lambda () (interactive) (evil-previous-line 6)))
              ("s" . 'ace-jump-mode)

              ("C-p" . 'fzf-git-files)
              ("C-c SPC" . 'tab-switch)
              ("M-." . 'xref-find-definitions)

              ("C-w C-h" . 'evil-window-left)
              ("C-w C-l" . 'evil-window-right)
              ("C-w C-k" . 'evil-window-up)
              ("C-w C-j" . 'evil-window-down)
              ("C-w f" . 'make-frame)
              ("C-w t" . 'tab-new)
              ("S-<prior>" . 'tab-previous)
              ("S-<next>" . 'tab-next)))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package evil-numbers
  :config
  (define-key evil-normal-state-map (kbd "C-c C-=") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-c C--") 'evil-numbers/dec-at-pt))

(use-package evil-nerd-commenter
  :bind (:map evil-normal-state-map
              ("M-;" . evilnc-comment-or-uncomment-lines)))

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
  (dashboard-items '((recents . 15)
                     (projects . 10)
                     (bookmarks . 5)
                     (registers . 5)))
  (dashboard-startupify-list
   '(dashboard-insert-banner
     dashboard-insert-items))
  :init
  (if (< (length command-line-args) 2)
      (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))))
  :config
  (dashboard-setup-startup-hook))

(use-package project
  :custom
  (project-vc-extra-root-markers
   '(".project.el"
     "cabal.project"
     "Cargo.toml")))

(use-package projectile
  :config
  (projectile-mode))

(use-package recentf
  :config
  (recentf-mode))

(use-package minimap)

(use-package fzf)

(use-package magit)

(use-package vdiff)

(use-package diff-hl
  :config
  (global-diff-hl-mode)
  (diff-hl-flydiff-mode)
  (unless window-system
    (diff-hl-margin-mode)))

(use-package flycheck
  :config
  (flycheck-add-next-checker 'python-mypy 'python-pyright 'append)
  (add-hook 'after-init-hook #'global-flycheck-mode))

(use-package company
  :custom
  (company-begin-commands '(self-insert-command))
  (company-require-match nil)
  (company-idle-delay .2)
  (company-minimum-prefix-length 2)
  (company-tooltip-limit 20)
  (company-tooltip-align-annotations t)
  (company-echo-delay 0)
  (company-selection-wrap-around t)
  (company-dabbrev-downcase nil)
  (company-dabbrev-ignore-case nil)
  :config
  (add-to-list 'company-backends '(company-capf :with company-dabbrev-code :separate))
  (add-hook 'after-init-hook 'global-company-mode)
  :bind (:map company-active-map
              ([tab] . company-complete-common-or-cycle) ; Use C-M-/ for dabbrev-completion
              ("C-f" . company-filter-candidates)
              ("C-p" . company-select-previous)
              ("C-n" . company-select-next)))

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
  (which-key-mode))

(use-package yaml-mode
  :mode
  (("\\.sls\\'" . yaml-mode)))

(use-package protobuf-mode)

(use-package goto-chg)

(use-package vundo
  :custom
  (vundo-compact-display t)
  (vundo-glyph-alist vundo-unicode-symbols)
  :bind (:map vundo-mode-map
              ("l" . 'vundo-forward)
              ("<right>" . 'vundo-forward)
              ("h" . 'vundo-backward)
              ("<left>" . 'vundo-backward)
              ("j" . 'vundo-next)
              ("<down>" . 'vundo-next)
              ("k" . 'vundo-previous)
              ("<up>" . 'vundo-previous)
              ("<home>" . 'vundo-stem-root)
              ("<end>" . 'vundo-stem-end)
              ("q" . 'vundo-quit)
              ("C-g" . 'vundo-quit)
              ("RET" . 'vundo-confirm)))

(use-package jinx
  :hook (emacs-startup . global-jinx-mode)
  :bind ([remap ispell-word] . jinx-correct))

(use-package markdown-mode
  :commands
  (markdown-mode gfm-mode)
  :mode
  (("README\\.md\\'" . gfm-mode)
   ("\\.md\\'" . markdown-mode)
   ("\\.markdown\\'" . markdown-mode))
  :custom
  (markdown-command "pandoc")
  (markdown-hide-markup t)
  :config
  (add-hook 'markdown-mode-hook #'visible-mode))

(use-package pandoc-mode
  :config
  (add-hook 'markdown-mode-hook #'pandoc-mode))

(use-package org
  :custom
  (org-confirm-babel-evaluate nil)
  (org-startup-indented t)
  (org-src-tab-acts-natively t)
  (org-src-preserve-indentation t)
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
  (org-bullets-bullet-list '("◉" "○" "●" "◈" "◇" "◆"))
  :config
  (add-hook 'org-mode-hook 'org-bullets-mode))

(use-package org-ql)

(use-package org-sidebar)

(use-package org-journal)

(use-package org-super-links
  :ensure nil
  :init
  (unless (package-installed-p 'org-super-links)
    (package-vc-install "https://github.com/toshism/org-super-links.git")))

(use-package deft
  :custom
  (deft-directory "~/notes")
  (deft-recursive t))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK"))

(use-package indent-bars
  :ensure nil
  :init
  (unless (package-installed-p 'indent-bars)
    ; TODO: pinning revision, something is broken upstream
    (package-vc-install "https://github.com/jdtsmith/indent-bars.git" "v0.2.3"))
  :custom
  (indent-bars-treesit-support t)
  (indent-bars-color '(highlight :face-bg t :blend 0.15))
  (indent-bars-pattern ".")
  (indent-bars-width-frac 0.1)
  (indent-bars-highlight-current-depth '(:blend 0.5))
  (indent-bars-display-on-blank-lines t)
  :hook (prog-mode . indent-bars-mode))

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
  (eglot-events-buffer-config '(:size 0 :format full))
  (eglot-events-buffer-size 0) ; TODO: getting deprecated, to be removed
  (eglot-autoshutdown t)
  :config
  (fset #'jsonrpc--log-event #'ignore)
  (add-to-list 'eglot-server-programs
               '((rust-ts-mode rust-mode) .
                 ("rust-analyzer" :initializationOptions
                  (:check (:command "clippy")
                   :inlayHints (:expressionAdjustmentHints (:enable "always")
                                :lifetimeElisionHints (:enable "always" :useParameterNames t))))))
  (add-to-list 'eglot-server-programs '(python-ts-mode . ("pyright-langserver" "--stdio")))
  (add-hook 'eglot-managed-mode-hook #'eglot-inlay-hints-mode)
  (add-hook 'eglot-managed-mode-hook
            (lambda ()
              (add-to-list 'company-backends '(company-capf :with company-dabbrev-code :separate))
              (flymake-mode -1)))
  (add-hook 'python-ts-mode-hook 'eglot-ensure))

(use-package eglot-booster
  :after eglot
  :ensure nil
  :init
  (unless (package-installed-p 'eglot-booster)
    (package-vc-install "https://github.com/jdtsmith/eglot-booster.git"))
  :config
  (add-to-list 'exec-path user-emacs-directory)
  (eglot-booster-mode))

(use-package vterm
  :custom
  (vterm-always-compile-module t))

(use-package multi-vterm
  :bind (("C-c s" . multi-vterm)
         ("C-c S" . multi-vterm-dedicated-toggle)))

(use-package imenu-list
  :custom
  (imenu-auto-rescan t)
  (imenu-list-auto-resize nil)
  (imenu-list-size 40)
  :bind (("C-c T" . imenu-list-smart-toggle)))

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

(use-package treesit-auto
  :custom
  (treesit-auto-install t)
  (treesit-auto-langs '(python))
  :config
  (add-to-list 'treesit-auto-recipe-list
               (make-treesit-auto-recipe
                :lang 'haskell
                :ts-mode 'haskell-ts-mode
                :remap 'haskell-mode
                :url "https://github.com/tree-sitter/tree-sitter-haskell"))
  (add-to-list 'treesit-auto-recipe-list
               (make-treesit-auto-recipe
                :lang 'elisp
                :ts-mode 'elisp-ts-mode
                :remap 'elisp-mode
                :url "https://github.com/Wilfred/tree-sitter-elisp"))
  (global-treesit-auto-mode)
  (add-hook 'tree-sitter-after-on-hook #'tree-sitter-hl-mode))

(use-package ts-fold
  :config
  (add-hook 'tree-sitter-after-on-hook #'ts-fold-indicators-mode))

(use-package evil-textobj-tree-sitter
  :after evil tree-sitter
  :config
  ;; Use it with `vaf`
  (define-key evil-outer-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.outer"))
  ;; Use it with `vif`
  (define-key evil-inner-text-objects-map "f" (evil-textobj-tree-sitter-get-textobj "function.inner"))
  ;; Use it with `vaa`
  (define-key evil-outer-text-objects-map "a" (evil-textobj-tree-sitter-get-textobj ("conditional.outer" "loop.outer"))))

(use-package flycheck-languagetool
  :disabled
  ;; The service needs to be started first with:
  ;; systemctl start languagetool.service
  :custom
  (flycheck-languagetool-server-jar "/usr/share/java/languagetool/languagetool-server.jar")
  :hook (text-mode . flycheck-languagetool-setup))

(use-package reformatter)

(use-package yasnippet
  :custom
  (yas-verbosity 1)
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode))

(use-package yasnippet-snippets)

(use-package citre
  :init
  (require 'citre-config)
  :custom
  (citre-auto-enable-citre-mode-modes '(prog-mode))
  (citre-project-root-function #'projectile-project-root)
  (citre-default-create-tags-file-location 'project-cache)
  (citre-use-project-root-when-creating-tags t)
  (citre-prompt-language-for-ctags-command t)
  :bind (:map citre-mode-map
              ("C-c j" . citre-jump)
              ("C-c J" . citre-jump-back)
              ("C-c ." . citre-peek) ; Use later citre-peek-through
              ("C-c c" . citre-create-tags-file)
              ("C-c u" . citre-update-tags-file)))

(use-package helpful
  :bind (([remap describe-symbol] . helpful-symbol)))

(use-package symbol-overlay)

(use-package literate-calc-mode)

(use-package gptel
  :custom
  (gptel-default-mode 'markdown-mode)
  (gptel-api-key (getenv "GPT_OPENAI_KEY"))
  (gptel-model "gpt-4o")
  :config
  (add-hook 'gptel-mode-hook 'visual-line-mode))

(use-package org-ai
  :commands (org-ai-mode
             org-ai-global-mode)
  :custom
  (org-ai-openai-api-token (getenv "GPT_OPENAI_KEY"))
  (org-ai-default-chat-model "gpt-4o")
  :init
  (add-hook 'org-mode-hook #'org-ai-mode)
  (org-ai-global-mode)
  :config
  (org-ai-install-yasnippets))

(use-package annotate
  :config
  (add-hook 'after-init-hook #'annotate-mode))

(use-package minions
  :config
  (minions-mode))

(use-package shackle
  :custom
  (shackle-default-size 0.33)
  (shackle-default-alignment 'below)
  (shackle-rules '((help-mode                    :select nil :align t)
                   (helpful-mode                 :select nil :align t)
                   (compilation-mode             :select nil :align t)
                   (vterm-mode                   :select t   :align t)
                   ("*scratch*"                  :select nil :align t)
                   ("*Messages*"                 :select nil :align t)
                   ("*Warnings*"                 :select nil :align t)
                   ("*Error*"                    :select nil :align t)
                   ("\*.*compile-log\*"          :select nil :align t :regexp t)
                   ("*annotations*"              :select nil :align right)
                   ("*eldoc*"                    :select nil :align t)
                   ("*Flycheck errors*"          :select nil :align t)
                   ("*ChatGPT*"                  :select t   :align below)))
  :config
  (shackle-mode))

(use-package popper
  :bind (("C-<return>" . popper-toggle)
         ("C-|" . popper-toggle-type)
         :map popper-mode-map
         ("C-\\" . popper-cycle))
  :custom
  (popper-display-control nil) ; Use shackle
  (popper-reference-buffers
   '(help-mode
     helpful-mode
     compilation-mode
     vterm-mode
     "\\*scratch\\*"
     "\\*Messages\\*"
     "\\*Warnings\\*"
     "\\*Error\\*"
     "\*.*compile-log\*"
     "\\*annotations\\*"
     "\\*eldoc\\*"
     "\\*Flycheck errors\\*"
     "\\*ChatGPT\\*"))
  :config
  (popper-mode)
  (popper-echo-mode))

(use-package breadcrumb
  :hook (prog-mode . breadcrumb-mode))

(use-package rmsbolt)

(use-package eldoc-box
  :if window-system
  :after eldoc
  :custom
  (eldoc-box-lighter t)
  (eldoc-box-only-multi-line t)
  (eldoc-box-clear-with-C-g t)
  :config
  (add-hook 'eldoc-mode-hook #'eldoc-box-hover-at-point-mode))
