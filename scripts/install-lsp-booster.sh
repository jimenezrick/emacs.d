#!/bin/bash

set -eu

RELEASE=v0.2.0/emacs-lsp-booster_v0.2.0_x86_64-unknown-linux-musl.zip

curl -L https://github.com/blahgeek/emacs-lsp-booster/releases/download/$RELEASE | funzip >~/.emacs.d/emacs-lsp-booster
chmod +x ~/.emacs.d/emacs-lsp-booster
