#!/bin/bash

set -eu

RELEASE=v0.2.1
BUILD=${RELEASE}/emacs-lsp-booster_${RELEASE}_x86_64-unknown-linux-musl.zip
URL=https://github.com/blahgeek/emacs-lsp-booster/releases/download/${BUILD}

curl -L $URL | funzip >~/.emacs.d/emacs-lsp-booster
chmod +x ~/.emacs.d/emacs-lsp-booster
