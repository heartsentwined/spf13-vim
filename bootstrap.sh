
# Backup existing .vim stuff
echo "backing up current vim config\n"
today=`date +%Y%m%d`
for i in $HOME/.vim $HOME/.vimrc $HOME/.gvimrc; do [ -e $i ] && [ ! -L $i ] && mv $i $i.$today; done


if [ ! -e $endpath/.git ]; then
    echo "cloning spf13-vim\n"
    git clone --recursive -b 3.0 http://github.com/heartsentwined/spf13-vim.git $endpath
else
    echo "updating spf13-vim"
    cd $endpath && git pull
fi


echo "copying .vim* files"
mv $endpath/.vimrc $HOME/.vimrc
mv $endpath/.vimrc.fork $HOME/.vimrc.fork
mv $endpath/.vimrc.bundles $HOME/.vimrc.bundles
mv $endpath/.vimrc.bundles.fork $HOME/.vimrc.bundles.fork
if [ ! -d $HOME/.vim/bundle ]; then
    mkdir -p $HOME/.vim/bundle
fi

echo "removing tmp folder"
rm -rf $endpath

if [ ! -e $HOME/.vim/bundle/vundle ]; then
    echo "Installing Vundle"
    git clone http://github.com/gmarik/vundle.git $HOME/.vim/bundle/vundle
fi

echo "update/install plugins using Vundle"
vim +BundleInstall! +BundleClean +qall
