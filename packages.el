(use-package helm
  :config
  (helm-mode 1)
  (setq helm-M-x-fuzzy-match t
	helm-buffers-fuzzy-matching t
	helm-recentf-fuzzy-match    t)
  (global-set-key (kbd "M-x") 'helm-M-x))

(use-package evil
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "C-j") (lambda () (interactive) (evil-next-line 6)))
  (define-key evil-normal-state-map (kbd "C-k") (lambda () (interactive) (evil-previous-line 6)))
  (define-key evil-insert-state-map (kbd "C-x C-o") 'company-complete)
  (define-key evil-normal-state-map (kbd "C-p") 'helm-find-files)
  (define-key evil-normal-state-map (kbd "SPC") 'helm-mini)
  (define-key evil-normal-state-map (kbd "s") 'ace-jump-mode))

(use-package key-chord
  :config
  (key-chord-mode 1)
  (key-chord-define evil-insert-state-map  "jk" 'evil-normal-state)
  (key-chord-define evil-normal-state-map  "kj" 'save-buffer))

(use-package neotree
  :config
  (setq neo-theme 'arrow
	neo-smart-open t))

(use-package sr-speedbar
  :config
  (setq speedbar-use-images nil))

; FIXME: initial-buffer-choice fails when a file is specified
(use-package dashboard
  :config
  (dashboard-setup-startup-hook)

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

(use-package projectile
  :config
  (projectile-mode 1))

(use-package recentf
  :config
  (recentf-mode 1))

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
