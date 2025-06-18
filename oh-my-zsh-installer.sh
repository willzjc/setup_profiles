#!/bin/bash
echo "Copying new theme to oh my zsh themes folder"
mkdir -p $HOME/.oh-my-zsh/themes
cp ./settings-for-oh-my-zsh/customtheme.zsh-theme $HOME/.oh-my-zsh/themes/.
echo "setting ~/.zshrc theme"
sed -i 's/^ZSH_THEME=.*/ZSH_THEME="customtheme"/' ~/.zshrc
