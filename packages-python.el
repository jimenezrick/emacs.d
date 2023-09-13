(use-package python-black
  :after python
  :hook (python-ts-mode . python-black-on-save-mode))

(use-package python-isort
  :after python
  :hook (python-ts-mode . python-isort-on-save-mode))
