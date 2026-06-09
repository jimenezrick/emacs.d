(defun transcribe-speech ()
  "Transcribe the recorded speech with whisper.cpp inserting it into the current buffer."
  (interactive)
  (let ((script-path "/mnt/scratch-nvme/ricardo/WHISPER/whisper.cpp/whisper-transcribe-speech.sh"))
    (if (not (file-executable-p script-path))
        (message "Error: could not find transcribe-speech script: %s" script-path)
      (progn
        (goto-char (1+ (point)))
        (insert (shell-command-to-string (concat script-path " print")))))))

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

(defun copy-file-line-llm ()
  "Copy project-relative file path plus current line or selected line range.

The copied format is:

  @path/to/file.ext:42
  @path/to/file.ext:42-57"
  (interactive)
  (let* ((file (or buffer-file-name
                   (user-error "Current buffer is not visiting a file")))
         (project-root (when-let ((project (project-current)))
                         (project-root project)))
         (relative-path (if project-root
                            (file-relative-name file project-root)
                          (file-name-nondirectory file)))
         (line-text
          (if (use-region-p)
              (let ((start-line (line-number-at-pos (region-beginning)))
                    (end-line (line-number-at-pos
                               ;; If the region ends at the beginning of a line,
                               ;; treat the previous line as the final selected line.
                               (if (= (region-end) (line-beginning-position))
                                   (max (point-min) (1- (region-end)))
                                 (region-end)))))
                (if (= start-line end-line)
                    (number-to-string start-line)
                  (format "%d-%d" start-line end-line)))
            (number-to-string (line-number-at-pos)))))
    (kill-new (format "@%s:%s" relative-path line-text))
    (message "Copied: %s:%s" relative-path line-text)))

(provide 'commands)
