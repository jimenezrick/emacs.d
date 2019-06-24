(use-package go-eldoc)

(use-package company-go)

(use-package go-projectile)

(use-package go-mode
  :init
  (defun go-mode-setup ()
    (go-eldoc-setup)
    (add-hook 'before-save-hook 'gofmt-before-save) 
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    (define-key evil-normal-state-map (kbd "C-]") 'godef-jump))
  :config
  (go-mode)
  (add-hook 'go-mode-hook 'go-mode-setup))
