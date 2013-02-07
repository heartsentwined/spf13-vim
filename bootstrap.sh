#!/usr/bin/env bash

echo "Backing up current vim config"
now=`date +%Y%m%d-%H%M%S`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc
do
    [ -e $i ] && [ ! -L $i ] && mv $i $i.$now
done

endpath=$HOME/.spf13-vim

if [ ! -e $endpath/.git ]; then
    echo "Cloning spf13-vim"
    git clone --recursive -b 3.0 http://github.com/heartsentwined/spf13-vim.git $endpath
else
    echo "Updating spf13-vim"
    cd $endpath && git pull
fi

echo "Copying .vim* files"
mv $endpath/.vimrc $HOME/.vimrc
mv $endpath/.vimrc.fork $HOME/.vimrc.fork
mv $endpath/.vimrc.bundles $HOME/.vimrc.bundles
mv $endpath/.vimrc.bundles.fork $HOME/.vimrc.bundles.fork
if [ ! -d $HOME/.vim/bundle ]; then
    mkdir -p $HOME/.vim/bundle
fi

echo "Removing tmp folder"
rm -rf $endpath

if [ ! -e $HOME/.vim/bundle/vundle ]; then
    echo "Installing Vundle"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "update/install plugins using Vundle"
vim +BundleInstall! +BundleClean +qall
