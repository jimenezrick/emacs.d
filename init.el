(defun my-get-fullpath (@file-relative-path)
  "Return the full path of *file-relative-path, relative to caller's file location."
    (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path)
)

(load (my-get-fullpath "repos"))
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (setq  package-selected-packages '(use-package))
  (package-install-selected-packages))

(eval-when-compile
  (require 'use-package))

(load (my-get-fullpath "packages"))
(load (my-get-fullpath "settings"))
(load (my-get-fullpath "custom"))
