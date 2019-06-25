(use-package go-eldoc)

(use-package company-go
  :custom
  (company-go-show-annotation t))

(use-package go-projectile)

(use-package go-mode
  :custom
  (gofmt-command "goimports")
  :init
  (defun go-mode-setup ()
    (go-eldoc-setup)
    (go-projectile-tools-add-path)
    (add-hook 'before-save-hook 'gofmt-before-save)
    (define-key evil-normal-state-map (kbd "C-]") 'godef-jump)
    (set (make-local-variable 'company-backends) '(company-go)) (company-mode))
  :config
  (go-mode)
  (add-hook 'go-mode-hook 'go-mode-setup))
