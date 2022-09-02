#!/bin/bash

set -eu

# See: https://github.com/dougm/go-projectile/blob/ad4ca3b5695a0e31e95e3cc4ccab498f87d68303/go-projectile.el#L67-L76
tools=(
	github.com/mdempsky/gocode
	golang.org/x/lint/golint
	github.com/rogpeppe/godef
	github.com/kisielk/errcheck
	golang.org/x/tools/cmd/godoc
	github.com/zmb3/gogetdoc
	golang.org/x/tools/cmd/goimports
	golang.org/x/tools/cmd/gorename
	golang.org/x/tools/cmd/gomvpkg
	golang.org/x/tools/cmd/guru
)

export GOBIN=~/emacs.d/gotools/bin

mkdir -p $GOBIN
for tool in ${tools[@]}
do
	go install ${tool}@latest
done
