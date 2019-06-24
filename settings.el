(require 'my-util)

(setq inhibit-startup-screen t)

; FIXME: (my-get-fullpath "backup")))
(setq
  backup-by-copying t
  backup-directory-alist '(("." . "~/.emacs.d/backup"))
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(global-display-line-numbers-mode)
(global-hl-line-mode 1)
(column-number-mode t)

(setq show-paren-delay 0)
(show-paren-mode 1)

(set-frame-font "Inconsolata-12")
(menu-bar-mode -1)
(tool-bar-mode -1)

(global-set-key (kbd "<f2>") 'save-buffer)
