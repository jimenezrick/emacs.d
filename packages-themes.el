(use-package plan9-theme
  :ensure t)

(use-package zerodark-theme
  :ensure t)

(use-package apropospriate-theme
  :ensure t)

(use-package spacemacs-theme
  :ensure t
  :no-require t
  :config

  (defun load-my-theme (&optional frame)
    (unless frame (setq frame (selected-frame)))
    (if (display-graphic-p frame)
	(load-theme 'spacemacs-light t)
      (load-theme 'spacemacs-light t)))

  (if (daemonp)
      (add-hook 'after-make-frame-functions
		(lambda (frame)
		  (with-selected-frame frame
		    (load-my-theme frame))))
    (load-my-theme)))
