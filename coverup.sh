#!/bin/bash

set -eu

task_name="$1"

coverup_folder="coverups"
coverup_tmp="$coverup_folder/tmp"
coverup_release="$coverup_folder/release"


echo "coverup $task_name .."

cd ../..
rm -rvf $coverup_tmp/$task_name
mkdir -p $coverup_tmp/$task_name

tar -cf $coverup_tmp/$task_name/$task_name.tar.xz $task_name

echo "Cover up done .."

cd $coverup_tmp/$task_name


acrypter encrypt cry15360 $task_name.tar.xz $task_name.tar.xz.acrypt
rm $task_name.tar.xz

if [ -z "${2+x}" ]; then
  echo " $task_name done over single file"
else
  acrypter split $task_name.tar.xz.acrypt $2 $task_name.tar.xz.acrypt
  rm $task_name.tar.xz.acrypt
fi


cd ../../..

rm -rvf $coverup_release/$task_name
mkdir -p $coverup_release

mv $coverup_tmp/$task_name $coverup_release/$task_name

echo "  --- All done --- "


