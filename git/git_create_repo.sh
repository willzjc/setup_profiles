#!/bin/bash

export git_user=willzjc
export repo='test_repo'

curl -u "$git_user" https://api.github.com/user/repos -d "{\"name\": \"$repo\"}"
