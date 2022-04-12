(use-package rust-mode
  :custom
  (rust-format-on-save t)
  :config
  (add-hook 'rust-mode-hook 'eglot-ensure))

(use-package flycheck-rust
  :config
  (add-hook 'rust-mode-hook #'flycheck-rust-setup))
