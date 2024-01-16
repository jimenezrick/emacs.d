(use-package almost-mono-themes
  :no-require t)

(use-package plan9-theme
  :no-require t)

(use-package zerodark-theme
  :no-require t)

(use-package apropospriate-theme
  :no-require t)

(use-package ef-themes
  :no-require t)

(use-package spacemacs-theme
  :no-require t  ; Hack needed for this package to work
  :init
  (defun load-my-theme (&optional frame)
    (with-selected-frame (or frame (selected-frame))
      (let ((hour (string-to-number (format-time-string "%H" (current-time)))))
        (if (display-graphic-p frame)
            (if (or (>= hour 21) (< hour 7))
                (load-theme 'spacemacs-dark t)
              (load-theme 'spacemacs-light t))
          (load-theme 'ef-bio t)))))
  :config
  (if (daemonp)
      (add-hook 'after-make-frame-functions 'load-my-theme)
    (add-hook 'after-init-hook 'load-my-theme)))
