(setq
  backup-by-copying t
  backup-directory-alist '(("." . "~/.emacs.d/backup"))
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

;(global-set-key "\C-x\C-b" 'buffer-menu)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(setq ido-use-virtual-buffers t)
(setq ido-use-filename-at-point 'guess)
(ido-mode 1)

(set-frame-font "Inconsolata-12")
(menu-bar-mode -1)
(tool-bar-mode -1)
