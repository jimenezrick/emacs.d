(use-package evil
  :ensure t
  :config
  (evil-mode 1)
  (define-key evil-normal-state-map (kbd "SPC") 'buffer-menu))

(use-package neotree
  :ensure t
  :config
  (setq neo-theme 'arrow)
  (setq neo-smart-open t))

(use-package speedbar
  :ensure t)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-startup-banner 'logo)
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

(use-package helm
  :ensure t)

(use-package fzf
  :ensure t)

(use-package magit
  :ensure t)

(use-package plan9-theme
  :ensure t)

(use-package spacemacs-theme
  :ensure t
  :no-require t
  :config
  (load-theme 'spacemacs-light t))
