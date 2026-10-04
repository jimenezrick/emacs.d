(use-package gptel
  :custom
  (gptel-default-mode 'markdown-mode)
  (gptel-expert-commands t)
  (gptel-model 'gpt-6-luna)
  (gptel-include-reasoning 'ignore)
  :config
  (gptel-make-openai "ChatGPT"
    :stream t
    :key (getenv "OPENAI_API_KEY"))
  (gptel-make-anthropic "Claude"
    :stream t
    :key (getenv "ANTHROPIC_API_KEY"))
  (gptel-make-openai "llama-cpp"
    :stream t
    :protocol "http"
    :host "localhost:8080"
    :models '(local-model)) ; Ignored
  ;; See: https://github.com/karthink/gptel/issues/1547
  (defvar-local my-opencode-session-id nil)
  (defun my-opencode-session-header (info)
    (with-current-buffer (plist-get info :buffer)
      (unless my-opencode-session-id
        (setq my-opencode-session-id
              (format "gptel-%s"
                      (md5 (format "%s-%s" (buffer-name) (float-time))))))
      `(("Authorization" . ,(concat "Bearer " (gptel--get-api-key)))
        ("x-opencode-session" . ,my-opencode-session-id))))
  (gptel-make-openai "OpenCode Go"
    :host "opencode.ai"
    :endpoint "/zen/go/v1/chat/completions"
    :key (getenv "OPENCODE_API_KEY")
    :header #'my-opencode-session-header
    :stream t
    :models '(deepseek-v4.1-flash
              glm-5.3
              glm-5.3-flash
              gpt-6-luna
              kimi-k3
              qwen3.7-plus
              qwen3.8-flash
              qwen3.8-max))
  (setq gptel-backend (gptel-get-backend "ChatGPT"))
  (add-hook 'gptel-mode-hook 'visual-line-mode)
  (add-hook 'gptel-mode-hook '(lambda () (auto-fill-mode -1)))
  :bind (:map gptel-mode-map
              ("C-x t" . transcribe-speech)))

(use-package gptel-quick
  :after gptel
  :vc (:url "https://github.com/karthink/gptel-quick.git" :rev :newest)
  :custom
  (gptel-quick-word-count 30)
  (gptel-quick-timeout 30)
  (gptel-quick-use-context t))

(use-package gptel-agent
  :after gptel
  :config (gptel-agent-update))

(use-package gptel-inline
  :after gptel
  :vc (:url "https://github.com/karthink/gptel-inline" :rev :newest))

(use-package gptel-annotate
  :after gptel
  :vc (:url "https://github.com/karthink/gptel-annotate" :rev :newest))

(use-package claude-code
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :custom
  (claude-code-program "claude-sandbox")
  (claude-code-terminal-backend 'vterm)
  (vterm-min-window-width 40)
  :config
  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map))

(use-package pimacs
  :vc (:url "https://github.com/ananthakumaran/pimacs.el" :rev "v0.3.0")
  :custom
  (pimacs-executable "pi-sandbox")
  :config
  (evil-set-initial-state 'pimacs-chat-mode 'emacs))
