(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  (setq helm-M-x-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match    t)
  (global-set-key (kbd "M-x") 'helm-M-x))

(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "C-j") (lambda () (interactive) (evil-next-line 6)))
  (define-key evil-normal-state-map (kbd "C-k") (lambda () (interactive) (evil-previous-line 6)))
  (define-key evil-insert-state-map (kbd "C-x o") 'company-complete)
  (define-key evil-normal-state-map (kbd "C-p") 'helm-find-files)
  (define-key evil-normal-state-map (kbd "SPC") 'helm-mini)
  (define-key evil-normal-state-map (kbd "s") 'ace-jump-mode))

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)
  (key-chord-define evil-normal-state-map  "kj" 'save-buffer))

(use-package neotree
  :ensure t
  :config
  (setq neo-theme 'arrow)
  (setq neo-smart-open t))

(use-package speedbar
  :ensure t
  :config
  (semantic-mode)
  (require 'semantic/sb))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (if (display-graphic-p)
    (setq dashboard-startup-banner 'logo)
    (setq dashboard-startup-banner nil))
  (setq dashboard-center-content t)
  (setq dashboard-banner-logo-title nil)
  (setq dashboard-set-init-info nil)
  (setq dashboard-set-footer nil)
  (setq dashboard-items '((recents . 10)
                        (bookmarks . 5)
                        (projects . 5)
                        (registers . 5))))

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1))

(use-package recentf
  :ensure t
  :config
  (recentf-mode 1))

(use-package minimap
  :ensure t)

(use-package fzf
  :ensure t)

(use-package magit
  :ensure t)

(use-package flycheck
  :ensure t
  :config
  (flycheck-mode))

(use-package company
  :ensure t
  :config
  (company-mode))

(use-package ace-jump-mode
  :ensure t)

(use-package rainbow-delimiters
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))

(use-package idle-highlight-mode
  :ensure t
  :config
  (add-hook 'prog-mode-hook #'idle-highlight-mode))

;; --- Color themes
(use-package plan9-theme
  :ensure t)

(use-package spacemacs-theme
  :ensure t
  :no-require t
  :config
  (load-theme 'spacemacs-light t))

;; --- Go
(use-package go-mode
  :ensure t
  :config
  (go-mode))

(use-package company-go
  :ensure t)
