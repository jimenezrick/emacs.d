(use-package ruff-format
  :after python
  :config
  (reformatter-define ruff-isort
    :program ruff-format-command
    :args (list "check" "--select" "I" "--fix" "--stdin-filename" (or (buffer-file-name) input-file))
    :lighter " RuffIsort"
    :group 'ruff-format)
  :hook (python-ts-mode . ruff-format-on-save-mode)
  :hook (python-ts-mode . ruff-isort-on-save-mode))
