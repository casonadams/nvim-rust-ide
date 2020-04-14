#!/bin/env bash

mkdir -p ~/.config/alacritty
ln -s alacritty.yml ~/.config/alacritty.yml

mkdir -p ~/.config/nvim
ln -s init.vim ~/.config/nvim/init.vim

ln -s editorconfig ~/.editorconfig
ln -s tmux.conf ~/.tmux.conf
