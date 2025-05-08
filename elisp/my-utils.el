(defun my-get-fullpath (@file-relative-path)
  "Return the full path of *file-relative-path, relative to caller's file location."
  (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path))

(defun voice-transcribe ()
  "Transcribe the recorded speech with whisper.cpp inserting it into the current buffer."
  (interactive)
  (let ((script-path "/mnt/scratch-nvme/ricardo/WHISPER/whisper.cpp/whisper-transcribe-to-input.sh"))
    (if (file-executable-p script-path)
        (insert (shell-command-to-string (concat script-path " print")))
      (message "Error: could not find voice-transcribe script: %s" script-path))))

(provide 'my-utils)
