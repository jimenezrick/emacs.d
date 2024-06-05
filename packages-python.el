(use-package ruff-format
  :after python
  :hook (python-ts-mode . ruff-format-on-save-mode))
