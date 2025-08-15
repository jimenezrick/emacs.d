(defun my-get-fullpath (@file-relative-path)
  "Return the full path of *file-relative-path, relative to caller's file location."
  (concat (file-name-directory (or load-file-name buffer-file-name)) @file-relative-path))

(defun transcribe-speech ()
  "Transcribe the recorded speech with whisper.cpp inserting it into the current buffer."
  (interactive)
  (let ((script-path "/mnt/scratch-nvme/ricardo/WHISPER/whisper.cpp/whisper-transcribe-speech.sh"))
    (if (not (file-executable-p script-path))
        (message "Error: could not find transcribe-speech script: %s" script-path)
      (insert (shell-command-to-string (concat script-path " print"))))))

(defun text-to-speech ()
  "Convert to speech with piper the text in the selected region, or from cursor to end of buffer if no region is selected."
  (interactive)
  (let ((script-path "/mnt/scratch-nvme/ricardo/WHISPER/piper/piper-speech.sh"))
    (if (not (file-executable-p script-path))
        (message "Error: could not find text-to-speech script: %s" script-path)
      (let ((text-content (string-trim
                           (if (use-region-p)
                               (buffer-substring-no-properties (region-beginning) (region-end))
                             (buffer-substring-no-properties (point) (point-max)))))
            (temp-file (make-temp-file "emacs-tts-")))
        (if (string-empty-p text-content)
            (message "No text to convert to speech")
          (progn
            (with-temp-file temp-file
              (insert text-content))
            (async-shell-command (format "%s \"%s\"; rm -f \"%s\"" script-path temp-file temp-file))))))))

(defun text-to-speech-llama ()
  "Convert to speech with piper the text in the selected region, or from cursor to end of buffer if no region is selected."
  (interactive)
  (let ((script-path "/mnt/scratch-nvme/ricardo/LLAMA/llama.cpp/llama-speech.sh"))
    (if (not (file-executable-p script-path))
        (message "Error: could not find text-to-speech script: %s" script-path)
      (let ((text-content (string-trim
                           (if (use-region-p)
                               (buffer-substring-no-properties (region-beginning) (region-end))
                             (buffer-substring-no-properties (point) (point-max)))))
            (temp-file (make-temp-file "emacs-tts-")))
        (if (string-empty-p text-content)
            (message "No text to convert to speech")
          (progn
            (with-temp-file temp-file
              (insert text-content))
            (async-shell-command (format "%s \"%s\"; rm -f \"%s\"" script-path temp-file temp-file))))))))

(provide 'my-utils)
