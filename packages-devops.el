(use-package terraform-mode)

(use-package terraform-doc)

(use-package jsonnet-mode)

(use-package kubernetes
  :commands (kubernetes-overview)
  :custom
  (kubernetes-poll-frequency 3600)
  (kubernetes-redraw-frequency 3600))

(use-package kubernetes-evil
  :after kubernetes)
