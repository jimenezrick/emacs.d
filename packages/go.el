(use-package go-projectile)

(use-package go-mode
  :custom
  (gofmt-command "goimports")
  :init
  (defun go-mode-setup ()
    (eglot-ensure)
    (go-projectile-tools-add-path)
    (add-hook 'before-save-hook 'gofmt-before-save)
    (define-key evil-normal-state-map (kbd "C-]") 'godef-jump))
  :config
  (add-hook 'go-mode-hook 'go-mode-setup))
