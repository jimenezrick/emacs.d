(add-to-list 'load-path "~/.emacs.d/lisp")
(require 'my-util)

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
