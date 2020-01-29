(use-package plan9-theme
  :no-require t)

(use-package zerodark-theme
  :no-require t)

(use-package apropospriate-theme
  :no-require t)

(use-package spacemacs-theme
  :no-require t  ; Hack needed for this package to work
  :init
  (defun load-my-theme (&optional frame)
    (unless frame (setq frame (selected-frame)))
    (let ((hour (string-to-number (format-time-string "%H" (current-time)))))
      (if (display-graphic-p frame)
          (if (or (>= hour 21) (< hour 7))
              (load-theme 'spacemacs-dark t)
            (load-theme 'spacemacs-light t))
        (load-theme 'spacemacs-light t))))
  :config
  (if (daemonp)
      (add-hook 'after-make-frame-functions
                (lambda (frame)
                  (with-selected-frame frame
                    (load-my-theme frame))))
    (load-my-theme)))
