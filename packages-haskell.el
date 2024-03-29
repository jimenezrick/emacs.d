(use-package haskell-mode
  :custom
  (haskell-process-type 'cabal-repl)
  (haskell-process-load-or-reload-prompt t)
  (haskell-process-auto-import-loaded-modules t)
  (haskell-process-log t)
  :config
  (reformatter-define cabal-format
    :program "cabal-fmt"
    :args '("/dev/stdin"))
  (add-hook 'haskell-mode-hook 'cabal-format-on-save-mode)

  (defun haskell-mode-setup ()
    (haskell-indentation-mode -1)
    (interactive-haskell-mode)

    (setq-local tab-stop-list '(2 4))
    (setq-local indent-line-function 'indent-relative)
    (setq-local tab-width 2)
    (setq-local evil-shift-width 2)

    (define-key evil-insert-state-map (kbd "TAB") 'tab-to-tab-stop)
    (define-key evil-normal-state-map (kbd "C-]") 'haskell-mode-goto-loc)
    (define-key evil-normal-state-map (kbd "C-c C-]") 'haskell-mode-tag-find)
    (define-key evil-normal-state-map (kbd "C-c C-t") 'haskell-mode-show-type-at))
  (add-hook 'haskell-mode-hook 'haskell-mode-setup)
  (add-hook 'haskell-mode-hook 'haskell-decl-scan-mode))

(use-package flycheck-haskell
  :config
  (setq-default flycheck-disabled-checkers '(haskell-stack-ghc))
  (add-hook 'haskell-mode-hook #'flycheck-haskell-setup))

(use-package company-ghci
  :after pos-tip
  :config
  (defun show-hoogle-info-in-popup ()
    (pos-tip-show (company-ghci/hoogle-info (symbol-at-point))))
  (defun company-ghci-setup ()
    (push 'company-ghci company-backends)
    (define-key evil-normal-state-map (kbd "C-;") (lambda () (interactive) (show-hoogle-info-in-popup))))
  (add-hook 'haskell-interactive-mode-hook 'company-mode)
  (add-hook 'haskell-mode-hook 'company-ghci-setup))

(use-package ormolu
  :hook (haskell-mode . ormolu-format-on-save-mode)
  :bind (:map haskell-mode-map
              ("C-c r" . ormolu-format-buffer)))

(use-package dhall-mode
  :mode "\\.dhall\\'")
