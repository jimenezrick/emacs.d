(setq-default inhibit-startup-screen t)

(setq-default
  backup-by-copying t
  backup-directory-alist `(("." . ,(expand-file-name "backup" user-emacs-directory)))
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

(setq-default
 indent-tabs-mode nil
 require-final-newline t
 truncate-lines t)

(global-display-line-numbers-mode)
(global-hl-line-mode)
(column-number-mode t)

(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'sh-mode-hook #'(lambda () (setq
                                      indent-tabs-mode t
                                      sh-basic-offset 8)))

(setq-default show-paren-delay 0)
(show-paren-mode)

(setq-default x-select-enable-clipboard t)

(setq-default tramp-default-method "ssh")

(set-frame-font "Inconsolata-12" t t)
(menu-bar-mode -1)
(tool-bar-mode -1)

(bind-key "<f2>" 'save-buffer)
