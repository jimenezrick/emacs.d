(defun my-get-fullpath (@file-relative-path)
  "Return the full path of *file-relative-path, relative to caller's file location."
  (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path))

(defun my-project-override (dir)
  "Override project root with dir whenever a .project.el file is found there."
  (let ((override (locate-dominating-file dir ".project.el")))
    (if override
        (cons 'vc override)
      nil)))

(provide 'my-utils)
