#!/bin/sh
config_dir=`pwd`/`dirname $0`
ln -s $config_dir/.vimrc.local $config_dir/..
ln -s $config_dir/.vimrc.bundles.local $config_dir/..
ln -s $config_dir/.zsh $config_dir/..
ln -s $config_dir/.zshrc $config_dir/..
