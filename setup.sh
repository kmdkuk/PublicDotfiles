#!/bin/bash

DOT_FILES=( .github.zshrc .vimrc .gitconfig .gitignore_global .zpreztorc )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/MyDotFiles/$file $HOME/$file
done

