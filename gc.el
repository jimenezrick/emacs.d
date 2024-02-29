;;; See: https://www.reddit.com/r/emacs/comments/yzb77m/an_easy_trick_i_found_to_improve_emacs_startup/ix08uwk/

;; Enable to show when a GC happens
;;(setq garbage-collection-messages t)

(defvar custom-gc-cons-threshold (* 64 1024 1024))

;; Avoid garbage collection during startup. The GC eats up quite a bit of time, easily
;; doubling the startup time. The trick is to turn up the memory threshold in order to
;; prevent it from running during startup.
(setq gc-cons-threshold most-positive-fixnum ; 2^61 bytes
      gc-cons-percentage 0.6)

;; Every file opened and loaded by Emacs will run through this list to check for a proper
;; handler for the file, but during startup, it won’t need any of them.
(defvar file-name-handler-alist-original file-name-handler-alist)
(setq file-name-handler-alist nil)

;; After Emacs startup has been completed, set `gc-cons-threshold' to
;; 16 MB and reset `gc-cons-percentage' to its original value.
;; Also reset `file-name-handler-alist'
(add-hook 'emacs-startup-hook
          #'(lambda ()
              (setq gc-cons-threshold custom-gc-cons-threshold
                    gc-cons-percentage 0.1
                    file-name-handler-alist file-name-handler-alist-original)
              (makunbound 'file-name-handler-alist-original)
              (message (emacs-init-time "Emacs startup time: %f seconds"))))

;; It may also be wise to raise gc-cons-threshold while the minibuffer is active, so the
;; GC doesn’t slow down expensive commands (or completion frameworks, like helm and ivy).
(defun defer-garbage-collection-h ()
  (setq gc-cons-threshold most-positive-fixnum))

(defun restore-garbage-collection-h ()
  ;; Defer it so that commands launched immediately after will enjoy the
  ;; benefits.
  (run-at-time
   1 nil (lambda () (setq gc-cons-threshold custom-gc-cons-threshold))))

(add-hook 'minibuffer-setup-hook #'defer-garbage-collection-h)
(add-hook 'minibuffer-exit-hook #'restore-garbage-collection-h)

;; Misc performance tweaks:
(setq read-process-output-max (* 1024 1024)
      process-adaptive-read-buffering nil)
