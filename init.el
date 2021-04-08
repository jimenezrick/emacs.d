(add-to-list 'load-path (expand-file-name "elisp" user-emacs-directory))

(load (expand-file-name "repos" user-emacs-directory))
(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (setq  package-selected-packages '(use-package))
  (package-install-selected-packages))

(eval-when-compile
  (require 'use-package))

(setq use-package-always-ensure t)

(load (expand-file-name "packages" user-emacs-directory))
(load (expand-file-name "packages-themes" user-emacs-directory))
(load (expand-file-name "packages-haskell" user-emacs-directory))
(load (expand-file-name "packages-rust" user-emacs-directory))
(load (expand-file-name "packages-go" user-emacs-directory))
(load (expand-file-name "packages-work" user-emacs-directory))
(load (expand-file-name "settings" user-emacs-directory))

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))
