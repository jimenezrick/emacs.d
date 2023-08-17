(use-package terraform-mode)

(use-package terraform-doc)

(use-package jsonnet-mode)

(use-package kubernetes
  :commands (kubernetes-overview))

(use-package kubernetes-evil
  :after kubernetes)
