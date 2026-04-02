(use-package terraform-mode)

(use-package terraform-doc)

(use-package jsonnet-mode
  :custom
  (jsonnet-indent-level 4)
  :config
  (reformatter-define jsonnet-format
    :program jsonnet-fmt-command
    :args (list "-n" (number-to-string jsonnet-indent-level) "--string-style" "d" "--no-pad-arrays" "-")
    :lighter " JnFmt"
    :group 'jsonnet-format)
  :hook (jsonnet-mode . jsonnet-format-on-save-mode))

(use-package kubernetes
  :commands (kubernetes-overview)
  :custom
  (kubernetes-poll-frequency 3600)
  (kubernetes-redraw-frequency 3600))

(use-package kubernetes-evil
  :after kubernetes)

(use-package es-mode)

(use-package just-mode)
