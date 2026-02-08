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



timex="$(date '+%Y_%m_%d_%H%M')"
task_fname="$task_name-$timex.tar.xz"

echo "tarball folder"
tar -cvf $coverup_tmp/$task_name/$task_fname $task_name

echo "Cover up done .."

cd $coverup_tmp/$task_name



acrypter encrypt cry15360 $task_fname $task_fname.acrypt
echo "Encryption Done"
if [ -f $task_name.tar.xz ]
then
	rm $task_name.tar.xz
fi

if [ -z "${2+x}" ]; then
  echo " $task_name done over single file"
else
  acrypter split $task_fname.acrypt $2 $task_fname.acrypt
  echo "Splitting Done"
  rm $task_fname
fi


cd ../../..

rm -rf $coverup_release/$task_name
mkdir -p $coverup_release

mv $coverup_tmp/$task_name $coverup_release/$task_name

echo "  --- All done --- "


