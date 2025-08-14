(use-package almost-mono-themes)

(use-package plan9-theme)

(use-package acme-theme)

(use-package zerodark-theme)

(use-package the-matrix-theme)

(use-package apropospriate-theme)

(use-package ef-themes)

(use-package spacemacs-theme)

(use-package emacs
  :after (consult ef-themes spacemacs-theme)
  :init
  (defun load-my-theme (&optional frame)
    (with-selected-frame (or frame (selected-frame))
      (let ((hour (string-to-number (format-time-string "%H" (current-time)))))
        (if (display-graphic-p frame)
            (if (or (>= hour 21) (< hour 7))
                (consult-theme 'spacemacs-dark)
              (consult-theme 'spacemacs-light))
          (consult-theme 'ef-bio)))))
  :config
  (if (daemonp)
      (add-hook 'after-make-frame-functions 'load-my-theme)
    (add-hook 'after-init-hook 'load-my-theme)))
