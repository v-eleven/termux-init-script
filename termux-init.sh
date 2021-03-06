#!/data/data/com.termux/files/usr/bin/bash

# define variable
TERMUX_HOME_CONFIG_PATH=~/.termux

# change software source
read -t 60 -n9 -p "Would you want to change the apt sources to Tsinghu Source?(y/n) " result
if [[ $result =~ y|Y && ! `cat $PREFIX/etc/apt/sources.list` =~ tsinghua ]]; then
    sed -i 's@^\(deb.*stable main\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable main@' $PREFIX/etc/apt/sources.list
    sed -i 's@^\(deb.*games stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games stable@' $PREFIX/etc/apt/sources.list.d/game.list
    sed -i 's@^\(deb.*science stable\)$@#\1\ndeb https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science stable@' $PREFIX/etc/apt/sources.list.d/science.list
fi

# install oh-my-zsh
sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)"

# customize key
mkdir -p $TERMUX_HOME_CONFIG_PATH
if [ ! -f $TERMUX_HOME_CONFIG_PATH/termux.properties ]; then
    echo "extra-keys = [['ESC','|','/','ALT','UP','QUOTE','APOSTROPHE'], ['TAB','CTRL','~','LEFT','DOWN','RIGHT','ENTER']]" >> $TERMUX_HOME_CONFIG_PATH/termux.properties
fi

# install base softwares
# the command `termux-chroot` can simulate root env
pkg update
pkg upgrade -y
pkg install -y proot openssh vim git wget

# start ssh service
# the default port is 8022
# see the user name by command `whoami`
sshd

# open shared mobile storage
termux-setup-storage

# Base Tutorial
# https://www.sqlsec.com/2018/05/termux.html
