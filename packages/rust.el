(use-package rust-mode
  :after treesit-auto
  :custom
  (rust-mode-treesitter-derive t)
  (rust-rustfmt-switches '("--edition" "2024"))
  (rust-format-on-save t)
  :config
  (delete 'rust treesit-auto-langs) ; Don't autoload rust-ts-mode (use instead derived rust-mode)
  (add-hook 'rust-mode-hook 'eglot-ensure))

(use-package flycheck-rust
  :config
  (flycheck-add-next-checker 'rust-cargo 'rust-clippy)
  (add-hook 'rust-mode-hook #'flycheck-rust-setup))
