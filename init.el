(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

(eval-when-compile
  (require 'use-package))

(defun my-get-fullpath (@file-relative-path)
  "Return the full path of *file-relative-path, relative to caller's file location."
    (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path)
)

(load (my-get-fullpath "packages.el"))
(load (my-get-fullpath "settings.el"))
(load (my-get-fullpath "custom.el"))
