#!/bin/bash

# TODO : greadlink in my MacBook Pro, use readlink in linux box
darcs_dir=$(greadlink -m $1)

if [[ ! -d $darcs_dir ]]; then
    echo "darcs repo \"$darcs_dir\" is not exist"
    exit 1
fi

git_dir=$darcs_dir-git

echo "$git_dir"

if [[ -d "git_dir" ]]; then
    echo "destination git repo \"$git_dir\" already exist"
    exit 2
fi

git init $git_dir && cd $darcs_dir && darcs-fastconvert export | (cd $git_dir ; git fast-import)

cd $git_dir && git checkout && cd ..

