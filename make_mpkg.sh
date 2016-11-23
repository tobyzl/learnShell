#!/bin/sh
echo '\033[34m [-----------------------create  install mpkg---------------------------] \033[0m'
cd `dirname $0`;
pad_dir=../../../PADGit/PAD7


#copy app

rm -drf ../PAD_System_Files
mkdir ../PAD_System_Files
TEMP_PATH="../PAD_System_Files"

function CopyAppFiles
{
local SRC_FILE_BUNDLE=$1
local BUNDLE_NAME=$2
local APP_FILE_BUNDLE="$TEMP_PATH"/"$BUNDLE_NAME".app
cp -R "$SRC_FILE_BUNDLE" "$APP_FILE_BUNDLE"
rm -f "$APP_FILE_BUNDLE"/Contents/Resources/RessData
}

#del old mpkg
rm -drf ../build
mkdir ../build

echo '  \033[34m [-*-*-*-*-*-*-Create Digitizer mpkg-*-*-*-*-*-*-] \033[0m'
CopyAppFiles "${pad_dir}/build/release/Digitizer.app" 'Digitizer Manager'
/usr/local/bin/freeze -v ../Digitizer.packproj

echo '  \033[34m [-*-*-*-*-*-*-Create Marker mpkg-*-*-*-*-*-*-*-] \033[0m'
CopyAppFiles "${pad_dir}/build/release/Marker.app" 'Marker Design'
/usr/local/bin/freeze -v ../Marker.packproj

echo '  \033[34m[-*-*-*-*-*-*-*-Create Pattern mpkg-*-*-*-*-*-*-] \033[0m'
CopyAppFiles "${pad_dir}/build/release/Pattern.app" 'Pattern Design'
/usr/local/bin/freeze -v ../Pattern.packproj

echo '  \033[34m [-*-*-*-*-*-*-*-*-Create Plot mpkg-*-*-*-*-*-*-] \033[0m'
CopyAppFiles "${pad_dir}/build/release/PlotManager.app" 'Plot Manager'
/usr/local/bin/freeze -v ../PlotManager.packproj

echo '  \033[34m [-*-*-*-*-*-*-*-Create AutoMark mpkg-*-*-*-*-*-*-] \033[0m'
CopyAppFiles "${pad_dir}/build/release/support/PADAutoMark/PADAutoMark.app" 'PAD AutoMark'
cp -r ${pad_dir}/build/release/PADAutoMarkDriver.app ../PAD_System_Files
/usr/local/bin/freeze -v ../PadAutoMark.packproj

echo '  \033[34m [-*-*-*-*-*-*-*-Create Estimate mpkg-*-*-*-*-*-*-] \033[0m'
CopyAppFiles "${pad_dir}/build/release/PADEstimate.app" 'PAD Estimate'
/usr/local/bin/freeze -v ../PadEstimate.packproj
