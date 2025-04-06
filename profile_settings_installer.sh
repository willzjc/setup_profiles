#!/bin/bash
echo "Setting profile config"
## Git
# git config --global user.email willzjc@gmail.com
git config --global user.name willzjc
# git config --global push.default current                      # Push current branch upstream always
git config --global credential.helper store                     # configure credential storage
git config --global http.sslverify false

# Set vim preferences
mkdir -p ~/.vim/undodir
mkdir -p ~/.vim/swp
mkdir -p ~/.vim/backupdir

echo """set paste
set hlsearch
syntax on
set backupdir=~/.vim/backupdir
set directory=~/.vim/swp
set undodir=~/.vim/undodir
""" > ~/.vimrc

echo "Installing source"
mkdir -p ~/.sourceprofile

if [ $(uname -s) = "Darwin" ] ; then
{
 touch ~/.sourceprofile/osx.sh
}
fi

mkdir -p ~/.sourceprofile
cp ./cfg_profile/source.sh ~/.sourceprofile/source.sh
cp ./cfg_profile/dircolors  ~/.sourceprofile/dircolors

echo -e "\nsource ~/.sourceprofile/source.sh\n" >> ~/.zshrc
echo -e "\nsource ~/.sourceprofile/source.sh\n" >> ~/.bashrc
