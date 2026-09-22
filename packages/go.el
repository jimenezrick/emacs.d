(use-package go-projectile)

(use-package go-ts-mode
  :hook
  (go-ts-mode . go-format-on-save-mode)
  :config
  (go-projectile-tools-add-path)
  (reformatter-define go-format
    :program "goimports"
    :args '("/dev/stdin")))
