(setq-default
 inhibit-startup-screen t
 initial-scratch-message ";; Eval sexp with C-x C-e and buffer with M-x eval-buffer\n")

(savehist-mode)

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

(setq bidi-inhibit-bpa t)
(setq-default bidi-paragraph-direction 'left-to-right)

(global-display-line-numbers-mode)
(global-hl-line-mode)
(column-number-mode t)
(blink-cursor-mode -1)
(setq-default visible-bell t)

(add-hook 'text-mode-hook #'flyspell-mode)
(add-hook 'prog-mode-hook #'flyspell-prog-mode)
(add-hook 'prog-mode-hook #'(lambda () (modify-syntax-entry ?_ "w")))
(add-hook 'python-mode-hook #'(lambda () (setq-local
                                          python-indent-guess-indent-offset-verbose nil)))
(add-hook 'sh-mode-hook #'(lambda () (setq-local
                                      indent-tabs-mode t
                                      sh-basic-offset 8)))

(setq-default show-paren-delay 0)
(show-paren-mode)

(setq-default
 x-select-enable-clipboard t
 x-select-enable-primary t
 mouse-drag-copy-region t)

(setq-default auth-source-save-behavior nil)
(setq-default tramp-default-method "ssh")

(setq-default tags-revert-without-query t)

(setq-default completions-detailed t)

(set-face-attribute 'default nil :family "Hack" :height 105)
(set-face-attribute 'variable-pitch nil :family "Junicode" :height 130)
(set-face-attribute 'bold nil :weight 'semibold)

(menu-bar-mode -1)
(tool-bar-mode -1)
(context-menu-mode)
(setq-default x-gtk-use-system-tooltips nil)
(winner-mode)

(bind-key "<f2>" 'save-buffer)

(add-to-list 'auto-mode-alist '("/tmp/mutt.*" . mail-mode))

(setq-default max-specpdl-size 3200)

;; Enable to show a backtrace on any error
;;(setq debug-on-error t)
