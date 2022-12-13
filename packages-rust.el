(use-package rust-mode
  :custom
  (rust-format-on-save t)
  :config
  (add-hook 'rust-mode-hook 'eglot-ensure))

(use-package flycheck-rust
  :config
  (flycheck-add-next-checker 'rust-cargo 'rust-clippy)
  (add-hook 'rust-mode-hook #'flycheck-rust-setup))
