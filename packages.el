(use-package helm
  :init
  (setq helm-M-x-fuzzy-match t
        helm-buffers-fuzzy-matching t
        helm-recentf-fuzzy-match    t)
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

(use-package ggtags
  :init
  (setq-local imenu-create-index-function #'ggtags-build-imenu-index))

(use-package treemacs
  :config
  (treemacs-tag-follow-mode)
  (treemacs-filewatch-mode t)
  (treemacs-fringe-indicator-mode t))

(use-package treemacs-evil)
(use-package treemacs-projectile)
(use-package treemacs-magit)

; FIXME: initial-buffer-choice fails when a file is specified
(use-package dashboard
  :init
  (if (display-graphic-p)
    (setq dashboard-startup-banner 'logo)
    (setq dashboard-startup-banner nil))
  (setq initial-buffer-choice (lambda () (get-buffer "*dashboard*"))
        dashboard-banner-logo-title nil
        dashboard-set-init-info nil
        dashboard-set-footer nil
        dashboard-items '((recents . 10)
                          (bookmarks . 5)
                          (projects . 5)
                          (registers . 5))))
:config
(dashboard-setup-startup-hook)

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
  (flycheck-mode))

(use-package company
  :config
  (add-hook 'after-init-hook 'global-company-mode))

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
  :init
  (setq whitespace-style '(face trailing spaces space-mark tabs tab-mark)
        whitespace-display-mappings
        '((space-mark  ?\   [?·])
          (tab-mark    ?\t  [?| ?\t])))
  :config
  (add-hook 'text-mode-hook #'whitespace-mode)
  (add-hook 'prog-mode-hook #'whitespace-mode))

(use-package which-key
  :config
  (which-key-mode)
  (which-key-setup-side-window-right))
