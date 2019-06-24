(use-package go-eldoc
  :ensure t)

(use-package company-go
  :ensure t)

(use-package go-projectile
  :ensure t)

(use-package go-mode
  :ensure t
  :config
  (go-mode)

  (defun go-mode-setup ()
    (go-eldoc-setup)
    (add-hook 'before-save-hook 'gofmt-before-save) 
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    (define-key evil-normal-state-map (kbd "C-]") 'godef-jump))

  (add-hook 'go-mode-hook 'go-mode-setup))
