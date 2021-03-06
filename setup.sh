#!/bin/bash

  DOT_FILES=(.CFUserTextEncoding .DS_Store .Trash .ansible .ansible.cfg .ansible_galaxy .atom .aws .bash_history .bundle .cocoapods .config .continuum .cups .docker .dropbox .emacs.d .gem .gitconfig .hammerspoon .ipython .itmstransporter .jupyter .lesshst .lldb .local .matplotlib .netrc .node-gyp .npm .oh-my-zsh .putty .pyenv .python_history .rbenv .rediscli_history .rubymotion .ssh .subversion .vagrant.d .vim .viminfo .z .z.18305 .zcompdump-Ender-5.2 .zcompdump-Ender-5.3 .zsh-update .zsh_history .zshrc .zshrc.pre-oh-my-zsh)

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done
