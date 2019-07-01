(use-package haskell-mode
  :custom
  (haskell-process-type 'cabal-new-repl)
  (haskell-process-suggest-remove-import-lines t)
  (haskell-process-auto-import-loaded-modules t)
  (haskell-process-log t)
  (haskell-tags-on-save t)

  (haskell-indentation-layout-offset 4)
  (haskell-indentation-starter-offset 4)
  (haskell-indentation-left-offset 4)
  (haskell-indentation-where-pre-offset 4)
  (haskell-indentation-where-post-offset 4)
  :config
  (defun haskell-mode-setup ()
    (interactive-haskell-mode)
    (setq tab-width 2)
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
  :config
  (push 'company-ghci company-backends)
  (add-hook 'haskell-interactive-mode-hook 'company-mode))

(use-package hindent
  :config
  (setq-default hindent-reformat-buffer-on-save t)
  (add-hook 'haskell-mode-hook #'hindent-mode))

(use-package dhall-mode
  :mode "\\.dhall\\'")

;; Fix hoogle doc when completing with company-ghci
(eval-after-load "company-ghci"
  '(defun company-ghci/hoogle-info (symbol)
     (when (executable-find "hoogle")
       (shell-command-to-string (format "hoogle --info \"%s\"" symbol)))))
