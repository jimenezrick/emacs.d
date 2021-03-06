(use-package rust-mode
  :custom
  (rust-format-on-save t))

(use-package flycheck-rust
  :config
  (add-hook 'rust-mode-hook #'flycheck-rust-setup))

(use-package racer
  :custom
  ;; FIXME: https://github.com/racer-rust/emacs-racer/issues/85
  (racer-rust-src-path (concat (string-trim (shell-command-to-string "rustc --print sysroot"))
                               "/lib/rustlib/src/rust/library"))
  :config
  (defun rust-mode-setup ()
    (racer-mode)
    (define-key evil-normal-state-map (kbd "C-]") 'racer-find-definition)
    (define-key evil-normal-state-map (kbd "C-;") 'racer-describe-tooltip))
  (add-hook 'rust-mode-hook #'rust-mode-setup)
  (add-hook 'racer-mode-hook #'eldoc-mode)
  (add-hook 'racer-mode-hook #'company-mode))
