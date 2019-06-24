(use-package go-eldoc
  :config
  (setq company-tooltip-limit 20)
  (setq company-idle-delay .3)
  (setq company-echo-delay 0)
  (setq company-begin-commands '(self-insert-command))
  )

(use-package company-go)

(use-package go-projectile)

(use-package go-mode
  :init
  (defun go-mode-setup ()
    (go-eldoc-setup)
    (go-projectile-tools-add-path)
    (setq gofmt-command "goimports")
    (add-hook 'before-save-hook 'gofmt-before-save)
    (define-key evil-normal-state-map (kbd "C-]") 'godef-jump)
    (set (make-local-variable 'company-backends) '(company-go)) (company-mode))
  :config
  (go-mode)
  (add-hook 'go-mode-hook 'go-mode-setup))
