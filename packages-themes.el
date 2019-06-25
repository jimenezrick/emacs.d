(use-package plan9-theme)
(use-package zerodark-theme)
(use-package apropospriate-theme)

(use-package spacemacs-theme
  ; Hack needed for this package to work
  :no-require t
  :init
  (defun load-my-theme (&optional frame)
    (unless frame (setq frame (selected-frame)))
    (if (display-graphic-p frame)
        (load-theme 'spacemacs-light t)
      (load-theme 'spacemacs-light t)))
  :config
  (if (daemonp)
      (add-hook 'after-make-frame-functions
                (lambda (frame)
                  (with-selected-frame frame
                    (load-my-theme frame))))
    (load-my-theme)))
