#!/bin/bash

# git config
# git config --global               # config
# git config --global --get-all
# git config --get-all
git config --global credential.helper store                   # configure credential storage
git config --global user.email "$USER@youremail.com"          # configure user email
git config --global http.sslverify false                      # don't verify SSL - used for VPN git repositories
git config --global http.postBuffer 1048576000
git config --global push.default current                      # Push current branch upstream always
