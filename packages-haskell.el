(use-package haskell-mode
  :custom
  (haskell-process-type 'cabal-new-repl))

(use-package flycheck-haskell
  :config
  (add-hook 'haskell-mode-hook #'flycheck-haskell-setup))

; complete <f1>
; M-x haskell-process-load-file
(use-package company-ghci
  :config
  (push 'company-ghci company-backends))

;; (use-package intero
;;   :config
;;   (Add-hook 'haskell-mode-hook #'intero-mode))

(use-package hindent
  :config
  (add-hook 'haskell-mode-hook #'hindent-mode))
