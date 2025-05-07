#!/bin/bash
echo "Setting profile config"
## Git
# git config --global user.email willzjc@gmail.com
git config --global user.name willzjc
# git config --global push.default current       # Push current branch upstream always
git config --global credential.helper cache     # Cache credentials in memory for use by future git commands
git config --global http.sslverify false

# Set vim preferences
echo "Setting vim config"
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

echo "Installing source profile"
mkdir -p ~/.sourceprofile

if [ $(uname -s) = "Darwin" ] ; then
{
 touch ~/.sourceprofile/osx.sh
}
fi

mkdir -p ~/.sourceprofile
cp ./cfg_profile/source.sh ~/.sourceprofile/source.sh
cp ./cfg_profile/dircolors  ~/.sourceprofile/dircolors

# Add source to shell config files only if not already present
if ! grep -q "source ~/.sourceprofile/source.sh" ~/.zshrc; then
  echo -e "\nsource ~/.sourceprofile/source.sh\n" >> ~/.zshrc
  echo "Added source to ~/.zshrc"
else
  echo "Source already exists in ~/.zshrc"
fi

if ! grep -q "source ~/.sourceprofile/source.sh" ~/.bashrc; then
  echo -e "\nsource ~/.sourceprofile/source.sh\n" >> ~/.bashrc
  echo "Added source to ~/.bashrc"
else
  echo "Source already exists in ~/.bashrc"
fi

# Call the Oh My Zsh installer script
./oh-my-zsh-installer.sh
