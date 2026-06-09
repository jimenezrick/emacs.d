(use-package gptel
  :custom
  (gptel-default-mode 'markdown-mode)
  (gptel-expert-commands t)
  (gptel-model 'gpt-5.4-nano)
  (gptel-include-reasoning 'ignore)
  :config
  (gptel-make-openai "ChatGPT"
    :stream t
    :key (getenv "OPENAI_API_KEY"))
  (gptel-make-anthropic "Claude"
    :stream t
    :key (getenv "EMACS_ANTHROPIC_API_KEY"))
  (gptel-make-openai "llama-cpp"
    :stream t
    :protocol "http"
    :host "localhost:8080"
    :models '(local-model)) ; Ignored
  (setq gptel-backend (gptel-get-backend "ChatGPT"))
  (add-hook 'gptel-mode-hook 'visual-line-mode)
  (add-hook 'gptel-mode-hook '(lambda () (auto-fill-mode -1)))
  :bind (:map gptel-mode-map
              ("C-x t" . transcribe-speech)))

(use-package gptel-quick
  :vc (:url "https://github.com/karthink/gptel-quick.git" :rev :newest)
  :custom
  (gptel-quick-word-count 30)
  (gptel-quick-timeout 30)
  (gptel-quick-use-context t))

(use-package gptel-agent
  :after gptel
  :config (gptel-agent-update))

(use-package claude-code
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :custom
  (claude-code-program "claude-sandbox")
  (claude-code-terminal-backend 'vterm)
  (vterm-min-window-width 40)
  :config
  (claude-code-mode)
  :bind-keymap ("C-c c" . claude-code-command-map))

(use-package pi
  :vc (:url "https://github.com/ananthakumaran/pi.el" :rev :newest)
  :custom
  (pi-executable "pi-sandbox")
  :commands (pi-chat))
