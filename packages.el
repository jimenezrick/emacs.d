(use-package helm
  :custom
  (helm-M-x-fuzzy-match t)
  (helm-buffers-fuzzy-matching t)
  (helm-recentf-fuzzy-match    t)
  :config
  (helm-mode)
  :bind (("M-x" . helm-M-x)
         ("M-y" . helm-show-kill-ring)))

(use-package evil
  :config
  (evil-mode)
  (define-key evil-normal-state-map (kbd "C-j") (lambda () (interactive) (evil-next-line 6)))
  (define-key evil-normal-state-map (kbd "C-k") (lambda () (interactive) (evil-previous-line 6)))
  (define-key evil-normal-state-map (kbd "s") 'ace-jump-mode)
  (define-key evil-insert-state-map (kbd "C-j") 'evil-normal-state)

  (define-key evil-normal-state-map (kbd "C-p") 'fzf-git-files)
  (define-key evil-normal-state-map (kbd "SPC") 'helm-mini)

  (define-key evil-insert-state-map (kbd "C-x C-o") 'company-complete))

(use-package evil-numbers
  :config
  (define-key evil-normal-state-map (kbd "C-c +") 'evil-numbers/inc-at-pt)
  (define-key evil-normal-state-map (kbd "C-c -") 'evil-numbers/dec-at-pt))

(use-package evil-nerd-commenter
  :config
  (evilnc-default-hotkeys))

(use-package ggtags
  :init
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index))

(use-package treemacs
  :custom
  (treemacs-no-png-images t)
  :config
  (treemacs-tag-follow-mode)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode t))

(use-package treemacs-evil)
(use-package treemacs-projectile)
(use-package treemacs-magit)

(use-package dashboard
  :custom
  (dashboard-banner-logo-title nil)
  (dashboard-set-init-info nil)
  (dashboard-set-footer nil)
  (dashboard-items '((recents . 10)
                     (bookmarks . 5)
                     (projects . 5)
                     (registers . 5)))
  :init
  (if (display-graphic-p)
      (setq dashboard-startup-banner 'logo)
    (setq dashboard-startup-banner nil))
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
  :config
  (add-hook 'after-init-hook 'global-company-mode)
  :bind (:map company-active-map
              ([tab] . company-complete-common-or-cycle)
              ("C-p" . company-select-previous-or-abort)
              ("C-n" . company-select-next-or-abort)))

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
  :config
  (add-to-list 'auto-mode-alist '("\\.sls\\'" . yaml-mode)))

(use-package goto-chg)

(use-package undo-tree
  :custom
  (undo-tree-visualizer-diff t)
  (undo-tree-visualizer-timestamps t)
  :config
  (global-undo-tree-mode))
