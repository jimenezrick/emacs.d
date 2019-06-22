(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(eval-when-compile
  (require 'use-package))

(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package spacemacs-theme
  :ensure t
  :no-require t
  :config
  (load-theme 'spacemacs-light t))

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

(set-frame-font "Inconsolata-12")
(menu-bar-mode -1)
(tool-bar-mode -1)
;; =============================================================
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(inhibit-startup-screen t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
