#!/usr/bin/env bash

CDIR="$(cd "$(dirname "$0")" && pwd)"
build_dir=$CDIR/build

while getopts A:K:q option
do
  case "${option}"
  in
    q) QUIET=1;;
    A) ARCH=${OPTARG};;
    K) KERNEL=${OPTARG};;
  esac
done

rm -rf $build_dir
mkdir -p $build_dir

for f in pluginrc.zsh
do
    cp $CDIR/$f $build_dir/
done

portable_url='https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep-13.0.0-x86_64-unknown-linux-musl.tar.gz'
extra_url='https://github.com/eth-p/bat-extras/releases/download/v2021.08.21/bat-extras-20210821.zip'
tarname=`basename $portable_url`
zipname=`basename $extra_url`
foldername='ripgrep-13.0.0-x86_64-unknown-linux-musl'
zipfolder='bat-extras'

cd $build_dir
mkdir -p $zipfolder

[ $QUIET ] && arg_q='-q' || arg_q=''
[ $QUIET ] && arg_s='-s' || arg_s=''
[ $QUIET ] && arg_progress='' || arg_progress='--show-progress'

if [ -x "$(command -v wget)" ]; then
 wget $arg_q $arg_progress $portable_url -O $tarname
 wget $arg_q $arg_progress $extra_url -O $zipname
elif [ -x "$(command -v curl)" ]; then
 curl $arg_s -L $portable_url -o $tarname
 curl $arg_s -L $extra_url -o $zipname
else
 echo Install wget or curl
fi

tar -xzf $tarname
mv $foldername ripgrep
rm $tarname

mv $zipname $zipfolder
cd $zipfolder
unzip $zipname
rm $zipname
