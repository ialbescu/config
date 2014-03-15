#!/bin/sh
config_dir=`pwd`/`dirname $0`
ln -s $config_dir/.vim $config_dir/..
ln -s $config_dir/.vimrc $config_dir/..
ln -s $config_dir/.zsh $config_dir/..
ln -s $config_dir/.zshrc $config_dir/..
