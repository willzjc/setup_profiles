#!/bin/bash
# install brew if not present
echo -e "Checking Brew"
if [[ $(brew --help) == "" ]] ; then 
{
    echo "Need to install brew" ; 
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}
else 
    echo "Exists"; 
fi

echo -e "Now checking git"
brew install git

echo -e "Now checking iterm2"
if [[ $(ls /Applications/iTerm.app) == "" ]] ; then
    echo -e "Iterm is installed"
else
{
    echo -e "Installing Iterm2"
    brew cask install iterm2
}
fi

echo -e "Now checking zsh"
if [[ $(which zsh) == "" ]] ; then
    echo -e "zsh is installed"
else
{
    echo -e "Installing zsh"
    brew install zsh
}
fi

echo -e "now checking if oh-my-zsh is installed"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
