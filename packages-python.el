(use-package python-black
  :after python
  :hook (python-mode . python-black-on-save-mode))

(use-package python-isort
  :hook (python-mode . python-isort-on-save-mode))
