(load-file "repos.el")
(package-initialize)
(package-refresh-contents)

(setq  package-selected-packages '(use-package))
(package-install-selected-packages)
