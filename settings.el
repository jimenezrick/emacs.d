(setq inhibit-startup-screen t)

(setq
  backup-by-copying t
  backup-directory-alist `(("." . ,(expand-file-name "backup" user-emacs-directory)))
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(setq-default truncate-lines t)
(setq-default indent-tabs-mode nil)

(global-display-line-numbers-mode)
(global-hl-line-mode)
(column-number-mode t)

(setq show-paren-delay 0)
(show-paren-mode)

(set-frame-font "Inconsolata-12")
(menu-bar-mode -1)
(tool-bar-mode -1)

(bind-key "<f2>" 'save-buffer)
