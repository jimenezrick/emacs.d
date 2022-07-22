(use-package rust-mode
  :custom
  (rust-format-on-save t)
  :config
  (add-hook 'rust-mode-hook 'eglot-ensure))

(use-package flycheck-rust
  :config
  ;; TODO: Temporary fix (https://github.com/flycheck/flycheck/issues/1916)
  (defun flycheck-rust-cargo-has-command-p (command)
    (let ((cargo (funcall flycheck-executable-find "cargo")))
      (cl-some (lambda (x) (string-prefix-p command x))
               (mapcar #'string-trim-left
                       (ignore-errors (process-lines cargo "--list"))))))
  (flycheck-add-next-checker 'rust-cargo 'rust-clippy)
  (add-hook 'rust-mode-hook #'flycheck-rust-setup))
