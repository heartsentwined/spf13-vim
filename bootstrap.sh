#!/usr/bin/env sh

endpath="$HOME/.spf13-vim-3"

warn() {
    echo "$1" >&2
}

die() {
    warn "$1"
    exit 1
}

lnif() {
    if [ ! -e $2 ] ; then
        ln -s $1 $2
    fi
}

echo "Thanks for installing spf13-vim\n"

# Backup existing .vim stuff
echo "backing up current vim config\n"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && [ ! -L $file ] && mv $i $i.$today; done


if [ ! -e $endpath/.git ]; then
    echo "cloning spf13-vim\n"
    git clone --recursive -b 3.0 http://github.com/heartsentwined/spf13-vim.git $endpath
else
    echo "updating spf13-vim\n"
    cd $endpath && git pull
fi


echo "copying .vim* files"
mv $endpath/.vimrc $HOME/.vimrc
mv $endpath/.vimrc.fork $HOME/.vimrc.fork
mv $endpath/.vimrc.bundles $HOME/.vimrc.bundles
mv $endpath/.vimrc.bundles.fork $HOME/.vimrc
mv $endpath/.vim $HOME/.vim
if [ ! -d $endpath/.vim/bundle ]; then
    mkdir -p $endpath/.vim/bundle
fi

echo "removing tmp folder"
rm -rf $endpath

if [ ! -e $HOME/.vim/bundle/vundle ]; then
    echo "Installing Vundle"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "update/install plugins using Vundle"
vim +BundleInstall! +BundleClean +qall
