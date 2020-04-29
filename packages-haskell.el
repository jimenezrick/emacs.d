(use-package haskell-mode
  :custom
  (haskell-process-type 'cabal-repl)
  (haskell-process-suggest-remove-import-lines t)
  (haskell-process-auto-import-loaded-modules t)
  (haskell-process-log t)
  (haskell-tags-on-save t)
  :config
  (defun haskell-mode-setup ()
    (haskell-indentation-mode -1)
    (interactive-haskell-mode)

    (setq-local tab-stop-list '(2 4))
    (setq indent-line-function 'indent-relative)
    (setq tab-width 2)
    (setq-local evil-shift-width 2)

    (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
    (define-key evil-normal-state-map (kbd "C-]") 'haskell-mode-goto-loc)
    (define-key evil-normal-state-map (kbd "C-c C-]") 'haskell-mode-tag-find)
    (define-key evil-normal-state-map (kbd "C-c C-t") 'haskell-mode-show-type-at))
  (add-hook 'haskell-mode-hook 'haskell-mode-setup))

(use-package flycheck-haskell
  :config
  (setq-default flycheck-disabled-checkers '(haskell-stack-ghc))
  (add-hook 'haskell-mode-hook #'flycheck-haskell-setup))

(use-package company-ghci
  :after (pos-tip)
  :config
  (defun show-hoogle-info-in-popup ()
    (pos-tip-show (company-ghci/hoogle-info (symbol-at-point)) nil nil nil -1))
  (defun company-ghci-setup ()
    (define-key evil-normal-state-map (kbd "C-;") (lambda () (interactive) (show-hoogle-info-in-popup))))
  (push 'company-ghci company-backends)
  (add-hook 'haskell-interactive-mode-hook 'company-mode)
  (add-hook 'haskell-mode-hook 'company-ghci-setup))

(use-package ormolu
  :load-path "lisp/ormolu"
  :hook (haskell-mode . ormolu-format-on-save-mode))

(use-package dhall-mode
  :mode "\\.dhall\\'")
