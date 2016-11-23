#!/bin/sh
echo '\033[35m [-------------------------------Start bundle ------------------------------] \033[0m'

cd `dirname $0`;
QTMAC=/Applications/Develop/Qt5.4.0/5.4/clang_64/bin/macdeployqt
pad_dir=../../../PADGit/PAD7

echo '  \033[35m [--------------------------bundle update---------------------------] \033[0m'

rm -fr ${pad_dir}/build/release/PadUpdater.app
cp -r ${pad_dir}/Common/Projects/PadUpdater/PadUpdater_app ${pad_dir}/build/release/PadUpdater.app
padupdate_contents_DIR=${pad_dir}/build/release/PadUpdater.app/Contents

echo 'copy PadUpdater languages'
mkdir ${padupdate_contents_DIR}/Resources/languages
cp -Rf ../languages/qt*.qm ${padupdate_contents_DIR}/Resources/languages
cp -Rf ../languages/PadUpdat*.qm ${padupdate_contents_DIR}/Resources/languages

mkdir ${padupdate_contents_DIR}/MacOS
cp ${pad_dir}/build/release/PadUpdater ${padupdate_contents_DIR}/MacOS

echo 'copy qt lib...'
$QTMAC ${pad_dir}/build/release/PadUpdater.app

echo '  \033[35m [--------------------------bundle pattern---------------------------] \033[0m'

pattern_contents_DIR=${pad_dir}/build/release/Pattern.app/Contents

rm -fr ${pad_dir}/build/release/Pattern.app
cp -r ${pad_dir}/Pattern/Projects/Pattern/Pattern_app ${pad_dir}/build/release/Pattern.app

mkdir ${pattern_contents_DIR}/MacOS
mkdir ${pattern_contents_DIR}/Frameworks
cp ${pad_dir}/build/release/Pattern ${pattern_contents_DIR}/MacOS
#copy dll
cp -R ${pad_dir}/build/release/PadUpdater.app ${pattern_contents_DIR}/MacOS
cp -R ${pad_dir}/build/release/libPadConjoin*.dylib ${pattern_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadCore*.dylib ${pattern_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadGeo*.dylib ${pattern_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadHelp*.dylib ${pattern_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadImpExp*.dylib ${pattern_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadNester*.dylib ${pattern_contents_DIR}/Frameworks


cp -R ${pad_dir}/build/release/libPatternConjoin*.dylib ${pattern_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPatternDB*.dylib ${pattern_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPatternFileConv*.dylib ${pattern_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPatternGraphic*.dylib ${pattern_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPatternTool*.dylib ${pattern_contents_DIR}/Frameworks

#copy plugins
echo 'pattern plugins'
mkdir ${pattern_contents_DIR}/plugins

mkdir ${pattern_contents_DIR}/plugins/io
cp -R ${pad_dir}/build/release/plugins/io/libPatternFileImp*.dylib ${pattern_contents_DIR}/plugins/io
cp -R ${pad_dir}/build/release/plugins/io/libPatternFileExp*.dylib ${pattern_contents_DIR}/plugins/io
cp -R ${pad_dir}/build/release/plugins/io/libPatternIO*.dylib ${pattern_contents_DIR}/plugins/io

mkdir ${pattern_contents_DIR}/plugins/assistant
cp -R ${pad_dir}/build/release/plugins/assistant/libPatternAssistant*.dylib ${pattern_contents_DIR}/plugins/assistant
#copy plot
mkdir ${pattern_contents_DIR}/plugins/plot
cp -R ${pad_dir}/build/release/plugins/plot/libPadPlotter*.dylib ${pattern_contents_DIR}/plugins/plot

cp -r ${pad_dir}/Common/Projects/PadPlotter/deploy/fonts ${pattern_contents_DIR}/plugins/plot
cp -r ${pad_dir}/Common/Projects/PadPlotter/deploy/plotter ${pattern_contents_DIR}/plugins/plot


echo 'pattern languages'
mkdir ${pattern_contents_DIR}/Resources/languages
cp -Rf ../languages/qt*.qm ${pattern_contents_DIR}/Resources/languages
cp -Rf ../languages/Patt*.qm ${pattern_contents_DIR}/Resources/languages
#register lib


install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/Frameworks/libPadConjoin.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/Frameworks/libPadConjoin.dylib

install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/Frameworks/libPadCore.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/Frameworks/libPadHelp.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/Frameworks/libPadImpExp.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/Frameworks/libPadImpExp.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/Frameworks/libPadImpExp.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/Frameworks/libPatternConjoin.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/Frameworks/libPatternConjoin.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/Frameworks/libPatternConjoin.dylib
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadNester.dylib $pattern_contents_DIR/Frameworks/libPatternConjoin.dylib


install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/Frameworks/libPatternDB.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/Frameworks/libPatternDB.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/Frameworks/libPatternDB.dylib
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadNester.dylib $pattern_contents_DIR/Frameworks/libPatternDB.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib $pattern_contents_DIR/Frameworks/libPatternDB.dylib
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib $pattern_contents_DIR/Frameworks/libPatternDB.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib $pattern_contents_DIR/Frameworks/libPatternDB.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/Frameworks/libPatternFileConv.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/Frameworks/libPatternFileConv.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/Frameworks/libPatternFileConv.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib $pattern_contents_DIR/Frameworks/libPatternFileConv.dylib
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib $pattern_contents_DIR/Frameworks/libPatternFileConv.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/Frameworks/libPatternGraphic.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/Frameworks/libPatternGraphic.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/Frameworks/libPatternGraphic.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib $pattern_contents_DIR/Frameworks/libPatternGraphic.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/Frameworks/libPatternTool.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/Frameworks/libPatternTool.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/Frameworks/libPatternTool.dylib
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib $pattern_contents_DIR/Frameworks/libPatternTool.dylib
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib $pattern_contents_DIR/Frameworks/libPatternTool.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib $pattern_contents_DIR/Frameworks/libPatternTool.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/MacOS/Pattern
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/MacOS/Pattern
install_name_tool -change libPadHelp.1.dylib @executable_path/../Frameworks/libPadHelp.dylib $pattern_contents_DIR/MacOS/Pattern
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadNester.dylib $pattern_contents_DIR/MacOS/Pattern
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/MacOS/Pattern
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib $pattern_contents_DIR/MacOS/Pattern
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib $pattern_contents_DIR/MacOS/Pattern
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib $pattern_contents_DIR/MacOS/Pattern
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib $pattern_contents_DIR/MacOS/Pattern
install_name_tool -change libPatternIO.1.dylib @executable_path/../plugins/io/libPatternIO.dylib $pattern_contents_DIR/MacOS/Pattern
install_name_tool -change libPatternAssistant.1.dylib @executable_path/../plugins/assistant/libPatternAssistant.dylib $pattern_contents_DIR/MacOS/Pattern

if [ -e $pattern_contents_DIR/plugins/assistant/libPatternAssistant.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/plugins/assistant/libPatternAssistant.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/plugins/assistant/libPatternAssistant.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/plugins/assistant/libPatternAssistant.dylib
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib $pattern_contents_DIR/plugins/assistant/libPatternAssistant.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib $pattern_contents_DIR/plugins/assistant/libPatternAssistant.dylib
fi
if [ -e $pattern_contents_DIR/plugins/io/libPatternFileImp.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/plugins/io/libPatternFileImp.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/plugins/io/libPatternFileImp.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/plugins/io/libPatternFileImp.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib $pattern_contents_DIR/plugins/io/libPatternFileImp.dylib
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib $pattern_contents_DIR/plugins/io/libPatternFileImp.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib $pattern_contents_DIR/plugins/io/libPatternFileImp.dylib
fi
if [ -e $pattern_contents_DIR/plugins/io/libPatternFileExp.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/plugins/io/libPatternFileExp.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/plugins/io/libPatternFileExp.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/plugins/io/libPatternFileExp.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib $pattern_contents_DIR/plugins/io/libPatternFileExp.dylib
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib $pattern_contents_DIR/plugins/io/libPatternFileExp.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib $pattern_contents_DIR/plugins/io/libPatternFileExp.dylib
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib $pattern_contents_DIR/plugins/io/libPatternFileExp.dylib
fi
if [ -e $pattern_contents_DIR/plugins/io/libPatternIO.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/plugins/io/libPatternIO.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/plugins/io/libPatternIO.dylib
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadNester.dylib $pattern_contents_DIR/plugins/io/libPatternIO.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib $pattern_contents_DIR/plugins/io/libPatternIO.dylib
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib $pattern_contents_DIR/plugins/io/libPatternIO.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib $pattern_contents_DIR/plugins/io/libPatternIO.dylib
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib $pattern_contents_DIR/plugins/io/libPatternIO.dylib

fi
if [ -e $pattern_contents_DIR/plugins/plot/libPadPlotter.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib $pattern_contents_DIR/plugins/plot/libPadPlotter.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib $pattern_contents_DIR/plugins/plot/libPadPlotter.dylib
fi

echo 'copy pattern qt lib...'
$QTMAC ${pad_dir}/build/release/Pattern.app



echo '  \033[35m [--------------------------bundle marker-----------------------------] \033[0m'

marker_contents_DIR=${pad_dir}/build/release/Marker.app/Contents

rm -fr ${pad_dir}/build/release/Marker.app
cp -r ${pad_dir}/Marker/Projects/Marker/Marker_app ${pad_dir}/build/release/Marker.app

mkdir ${marker_contents_DIR}/MacOS
mkdir ${marker_contents_DIR}/Frameworks
cp ${pad_dir}/build/release/Marker ${marker_contents_DIR}/MacOS
#copy updater
cp -R ${pad_dir}/build/release/PadUpdater.app ${marker_contents_DIR}/MacOS
#copy dll
cp -R ${pad_dir}/build/release/libPadCore*.dylib ${marker_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadConjoin*.dylib ${marker_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadGeo*.dylib ${marker_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadHelp*.dylib ${marker_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadImpExp*.dylib ${marker_contents_DIR}/Frameworks


cp -R ${pad_dir}/build/release/libMarkerDB*.dylib ${marker_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libMarkerApi*.dylib ${marker_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libMarkerTool*.dylib ${marker_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libMarkerKeypad*.dylib ${marker_contents_DIR}/Frameworks


mkdir ${marker_contents_DIR}/plugins
mkdir ${marker_contents_DIR}/plugins/plot
#copy plot lib
cp -R ${pad_dir}/build/release/plugins/plot/libPadPlotter*.dylib ${marker_contents_DIR}/plugins/plot
cp -r ${pad_dir}/Common/Projects/PadPlotter/deploy/fonts ${marker_contents_DIR}/plugins/plot
cp -r ${pad_dir}/Common/Projects/PadPlotter/deploy/plotter ${marker_contents_DIR}/plugins/plot

mkdir ${marker_contents_DIR}/plugins/cmds
cp -R ${pad_dir}/build/release/plugins/cmds/libMarkerCmds*.dylib ${marker_contents_DIR}/plugins/cmds

mkdir ${marker_contents_DIR}/plugins/io
cp -R ${pad_dir}/build/release/plugins/io/libMarkerFileExp*.dylib ${marker_contents_DIR}/plugins/io
cp -R ${pad_dir}/build/release/plugins/io/libMarkerFileImp*.dylib ${marker_contents_DIR}/plugins/io
cp -R ${pad_dir}/build/release/plugins/io/libMarkerIO*.dylib ${marker_contents_DIR}/plugins/io
cp -R ${pad_dir}/Marker/Projects/MarkerFileExp/deploy/* ${marker_contents_DIR}/plugins/io

echo 'copy marker languages'
mkdir ${marker_contents_DIR}/Resources/languages
cp -Rf ../languages/qt*.qm ${marker_contents_DIR}/Resources/languages
cp -Rf ../languages/Marker*.qm ${marker_contents_DIR}/Resources/languages


#register lib
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/Frameworks/libMarkerDB.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/Frameworks/libMarkerDB.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${marker_contents_DIR}/Frameworks/libMarkerDB.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${marker_contents_DIR}/Frameworks/libMarkerDB.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/Frameworks/libMarkerApi.dylib
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${marker_contents_DIR}/Frameworks/libMarkerApi.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/Frameworks/libMarkerTool.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/Frameworks/libMarkerTool.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${marker_contents_DIR}/Frameworks/libMarkerTool.dylib
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${marker_contents_DIR}/Frameworks/libMarkerTool.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/Frameworks/libMarkerKeypad.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/Frameworks/libMarkerKeypad.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${marker_contents_DIR}/Frameworks/libMarkerKeypad.dylib
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${marker_contents_DIR}/Frameworks/libMarkerKeypad.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/Frameworks/libPadConjoin.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/Frameworks/libPadConjoin.dylib

install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/Frameworks/libPadCore.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/Frameworks/libPadHelp.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/Frameworks/libPadImpExp.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/Frameworks/libPadImpExp.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${marker_contents_DIR}/Frameworks/libPadImpExp.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/MacOS/Marker
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/MacOS/Marker
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${marker_contents_DIR}/MacOS/Marker
install_name_tool -change libPadHelp.1.dylib @executable_path/../Frameworks/libPadHelp.dylib ${marker_contents_DIR}/MacOS/Marker
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${marker_contents_DIR}/MacOS/Marker
install_name_tool -change libMarkerIO.1.dylib @executable_path/../Frameworks/libMarkerIO.dylib ${marker_contents_DIR}/MacOS/Marker
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${marker_contents_DIR}/MacOS/Marker
install_name_tool -change libMarkerApi.1.dylib @executable_path/../Frameworks/libMarkerApi.dylib ${marker_contents_DIR}/MacOS/Marker
install_name_tool -change libMarkerTool.1.dylib @executable_path/../Frameworks/libMarkerTool.dylib ${marker_contents_DIR}/MacOS/Marker

# install plugin MarkerCmds
if [ -e ${marker_contents_DIR}/plugins/cmds/libMarkerCmds.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/plugins/cmds/libMarkerCmds.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/plugins/cmds/libMarkerCmds.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${marker_contents_DIR}/plugins/cmds/libMarkerCmds.dylib
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${marker_contents_DIR}/plugins/cmds/libMarkerCmds.dylib
else
echo "No libMarkerCmds.dylib"
fi

# install plugin FileExport
if [ -e ${marker_contents_DIR}/plugins/io/libMarkerFileExp.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileExp.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileExp.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileExp.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileExp.dylib
install_name_tool -change libMarkerApi.1.dylib @executable_path/../Frameworks/libMarkerAPI.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileExp.dylib
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileExp.dylib
else
echo "No libMarkerFileExp.dylib"
fi

# install plugin FileImporter
if [ -e ${marker_contents_DIR}/plugins/io/libMarkerFileImp.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileImp.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileImp.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileImp.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileImp.dylib
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${marker_contents_DIR}/plugins/io/libMarkerFileImp.dylib
else
echo "No libMarkerFileImp.dylib"
fi

# install plugin MarkerIO
if [ -e ${marker_contents_DIR}/plugins/io/libMarkerIO.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${marker_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${marker_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${marker_contents_DIR}/plugins/io/libMarkerIO.dylib
else
echo "NO libMarkerIO.dylib"
fi

# install plugin PadPlotter
if [ -e ${marker_contents_DIR}/plugins/plot/libPadPlotter.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${marker_contents_DIR}/plugins/plot/libPadPlotter.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${marker_contents_DIR}/plugins/plot/libPadPlotter.dylib
else
echo "No libPadPlotter.dylib"
fi

echo 'copy Marker qt lib...'
$QTMAC ${pad_dir}/build/release/Marker.app


echo '  \033[35m [--------------------------bundle estimate--------------------------] \033[0m'

estimate_contents_DIR=${pad_dir}/build/release/PADEstimate.app/Contents

rm -fr ${pad_dir}/build/release/PADEstimate.app
cp -r ${pad_dir}/Marker/Projects/PADEstimate/PADEstimate_app ${pad_dir}/build/release/PADEstimate.app

mkdir ${estimate_contents_DIR}/MacOS
mkdir ${estimate_contents_DIR}/Frameworks
mkdir ${estimate_contents_DIR}/plugins
#copy updater
cp -R ${pad_dir}/build/release/PadUpdater.app ${estimate_contents_DIR}/MacOS
#copy dll
cp ${pad_dir}/build/release/PADEstimate ${estimate_contents_DIR}/MacOS
cp -R ${pad_dir}/build/release/libMarkerApi*.dylib ${estimate_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libMarkerDB*.dylib ${estimate_contents_DIR}/Frameworks

cp -R ${pad_dir}/build/release/libPadCore*.dylib ${estimate_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadGeo*.dylib ${estimate_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadConjoin*.dylib ${estimate_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadImpExp*.dylib ${estimate_contents_DIR}/Frameworks

mkdir ${estimate_contents_DIR}/plugins/io
cp -R ${pad_dir}/build/release/plugins/io/libMarkerIO*.dylib ${estimate_contents_DIR}/plugins/io

echo 'copy marker languages'
mkdir ${estimate_contents_DIR}/Resources/languages
cp -Rf ../languages/qt*.qm ${estimate_contents_DIR}/Resources/languages
cp -Rf ../languages/PADEstimat*.qm ${estimate_contents_DIR}/Resources/languages

#register lib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${estimate_contents_DIR}/Frameworks/libPadCore.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${estimate_contents_DIR}/Frameworks/libMarkerApi.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${estimate_contents_DIR}/Frameworks/libMarkerApi.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${estimate_contents_DIR}/Frameworks/libMarkerDB.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${estimate_contents_DIR}/Frameworks/libMarkerDB.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${estimate_contents_DIR}/Frameworks/libMarkerDB.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${estimate_contents_DIR}/Frameworks/libMarkerDB.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${estimate_contents_DIR}/Frameworks/libPadConjoin.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${estimate_contents_DIR}/Frameworks/libPadConjoin.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${estimate_contents_DIR}/Frameworks/libPadImpExp.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${estimate_contents_DIR}/Frameworks/libPadImpExp.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${estimate_contents_DIR}/Frameworks/libPadImpExp.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${estimate_contents_DIR}/MacOS/PADEstimate
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${estimate_contents_DIR}/MacOS/PADEstimate
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${estimate_contents_DIR}/MacOS/PADEstimate
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${estimate_contents_DIR}/MacOS/PADEstimate
install_name_tool -change libMarkerApi.1.dylib @executable_path/../Frameworks/libMarkerApi.dylib ${estimate_contents_DIR}/MacOS/PADEstimate
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${estimate_contents_DIR}/MacOS/PADEstimate

# install plugin MarkerIO
if [ -e ${estimate_contents_DIR}/plugins/io/libMarkerIO.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${estimate_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${estimate_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${estimate_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${estimate_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${estimate_contents_DIR}/plugins/io/libMarkerIO.dylib
fi

echo 'copy PADEstimate qt lib...'
$QTMAC ${pad_dir}/build/release/PADEstimate.app

echo '  \033[35m [--------------------------bundle Automark---------------------------] \033[0m'

automark_contents_DIR=${pad_dir}/build/release/support/PADAutoMark/PADAutoMark.app/Contents

rm -fr ${pad_dir}/build/release/support/PADAutoMark/PADAutoMark.app
cp -r ${pad_dir}/Marker/Projects/PADAutoMark/PADAutoMark_app ${pad_dir}/build/release/support/PADAutoMark/PADAutoMark.app

mkdir ${automark_contents_DIR}/MacOS
mkdir ${automark_contents_DIR}/Frameworks
mkdir ${automark_contents_DIR}/plugins

#copy updater
cp -R ${pad_dir}/build/release/PadUpdater.app ${automark_contents_DIR}/MacOS
#copy dll
cp ${pad_dir}/build/release/support/PADAutoMark/PADAutoMark ${automark_contents_DIR}/MacOS

cp -R ${pad_dir}/3rdParty/SFN/libs/MAC/PADAutoMark.dylib ${automark_contents_DIR}/Frameworks
cp -R ${pad_dir}/3rdParty/SFN/libs/MAC/shield.dylib ${automark_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libMarkerApi*.dylib ${automark_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadCore*.dylib ${automark_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadGeo*.dylib ${automark_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadConjoin*.dylib ${automark_contents_DIR}/Frameworks

echo 'copy automark languages'
mkdir ${automark_contents_DIR}/Resources/languages
cp -Rf ../languages/qt*.qm ${automark_contents_DIR}/Resources/languages
cp -Rf ../languages/PADAutoMar*.qm ${automark_contents_DIR}/Resources/languages
#register lib

install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${automark_contents_DIR}/Frameworks/libPadCore.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${automark_contents_DIR}/Frameworks/libMarkerApi.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${automark_contents_DIR}/Frameworks/libMarkerApi.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${automark_contents_DIR}/Frameworks/libPadConjoin.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${automark_contents_DIR}/Frameworks/libPadConjoin.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${automark_contents_DIR}/MacOS/PADAutoMark
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${automark_contents_DIR}/MacOS/PADAutoMark
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${automark_contents_DIR}/MacOS/PADAutoMark
install_name_tool -change libMarkerApi.1.dylib @executable_path/../Frameworks/libMarkerApi.dylib ${automark_contents_DIR}/MacOS/PADAutoMark
echo 'copy Automark qt lib...'
$QTMAC ${pad_dir}/build/release/support/PADAutoMark/PADAutoMark.app

echo '  \033[35m [--------------------------bundle digitizer---------------------------] \033[0m'

digitizer_contents_DIR=${pad_dir}/build/release/Digitizer.app/Contents


rm -fr ${pad_dir}/build/release/Digitizer.app
cp -r ${pad_dir}/Utility/Projects/Digitizer/Digitizer_app ${pad_dir}/build/release/Digitizer.app

mkdir ${digitizer_contents_DIR}/MacOS
mkdir ${digitizer_contents_DIR}/Frameworks
mkdir ${digitizer_contents_DIR}/plugins
#copy updater
cp -R ${pad_dir}/build/release/PadUpdater.app ${digitizer_contents_DIR}/MacOS
#copy lib
cp ${pad_dir}/build/release/Digitizer ${digitizer_contents_DIR}/MacOS
cp -R ${pad_dir}/build/release/libPadNester*.dylib ${digitizer_contents_DIR}/Frameworks


cp -R ${pad_dir}/build/release/libPatternDB*.dylib ${digitizer_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPatternGraphic*.dylib ${digitizer_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPatternConjoin*.dylib ${digitizer_contents_DIR}/Frameworks

cp -R ${pad_dir}/build/release/libDigitizerGeneric*.dylib ${digitizer_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libDigitizerTool*.dylib ${digitizer_contents_DIR}/Frameworks

cp -R ${pad_dir}/build/release/libPadImpExp*.dylib ${digitizer_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadCore*.dylib ${digitizer_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadGeo*.dylib ${digitizer_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadConjoin*.dylib ${digitizer_contents_DIR}/Frameworks
#copy files
cp ${pad_dir}/Utility/Projects/Digitizer/deploy/Digitizer.xml ${digitizer_contents_DIR}/Resources
cp -r ${pad_dir}/Utility/Projects/DigitizerGeneric/deploy/* ${digitizer_contents_DIR}/plugins

mkdir ${digitizer_contents_DIR}/plugins/io
cp -R ${pad_dir}/build/release/plugins/io/libPatternIO*.dylib ${digitizer_contents_DIR}/plugins/io


echo 'digitizer languages'
mkdir ${digitizer_contents_DIR}/Resources/languages
cp -Rf ../languages/qt*.qm ${digitizer_contents_DIR}/Resources/languages
cp -Rf ../languages/Digitize*.qm ${digitizer_contents_DIR}/Resources/languages
#register lib
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${digitizer_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${digitizer_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${digitizer_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadNester.dylib ${digitizer_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${digitizer_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib ${digitizer_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib ${digitizer_contents_DIR}/Frameworks/libPatternDB.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${digitizer_contents_DIR}/Frameworks/libPatternConjoin.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${digitizer_contents_DIR}/Frameworks/libPatternConjoin.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${digitizer_contents_DIR}/Frameworks/libPatternConjoin.dylib
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadNester.dylib ${digitizer_contents_DIR}/Frameworks/libPatternConjoin.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${digitizer_contents_DIR}/Frameworks/libPatternGraphic.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${digitizer_contents_DIR}/Frameworks/libPatternGraphic.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${digitizer_contents_DIR}/Frameworks/libPatternGraphic.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib ${digitizer_contents_DIR}/Frameworks/libPatternGraphic.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${digitizer_contents_DIR}/Frameworks/libDigitizerGeneric.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${digitizer_contents_DIR}/Frameworks/libDigitizerGeneric.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${digitizer_contents_DIR}/Frameworks/libDigitizerGeneric.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${digitizer_contents_DIR}/Frameworks/libDigitizerTool.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${digitizer_contents_DIR}/Frameworks/libDigitizerTool.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${digitizer_contents_DIR}/Frameworks/libDigitizerTool.dylib
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib ${digitizer_contents_DIR}/Frameworks/libDigitizerTool.dylib
install_name_tool -change libDigitizerGeneric.1.dylib @executable_path/../Frameworks/libDigitizerGeneric.dylib ${digitizer_contents_DIR}/Frameworks/libDigitizerTool.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${digitizer_contents_DIR}/Frameworks/libPadConjoin.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${digitizer_contents_DIR}/Frameworks/libPadConjoin.dylib

install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${digitizer_contents_DIR}/Frameworks/libPadCore.dylib

install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${digitizer_contents_DIR}/Frameworks/libPadImpExp.dylib
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${digitizer_contents_DIR}/Frameworks/libPadImpExp.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${digitizer_contents_DIR}/Frameworks/libPadImpExp.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${digitizer_contents_DIR}/MacOS/Digitizer
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${digitizer_contents_DIR}/MacOS/Digitizer
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${digitizer_contents_DIR}/MacOS/Digitizer
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${digitizer_contents_DIR}/MacOS/Digitizer
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadNester.dylib ${digitizer_contents_DIR}/MacOS/Digitizer
#install_name_tool -change libDigitizerDB.1.dylib @executable_path/../Frameworks/libDigitizerDB.dylib ${digitizer_contents_DIR}/MacOS/Digitizer
install_name_tool -change libDigitizerGeneric.1.dylib @executable_path/../Frameworks/libDigitizerGeneric.dylib ${digitizer_contents_DIR}/MacOS/Digitizer
install_name_tool -change libDigitizerTool.1.dylib @executable_path/../Frameworks/libDigitizerTool.dylib ${digitizer_contents_DIR}/MacOS/Digitizer
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib ${digitizer_contents_DIR}/MacOS/Digitizer
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib ${digitizer_contents_DIR}/MacOS/Digitizer
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib ${digitizer_contents_DIR}/MacOS/Digitizer


if [ -e ${digitizer_contents_DIR}/plugins/io/libPatternIO.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${digitizer_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${digitizer_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${digitizer_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${digitizer_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib ${digitizer_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib ${digitizer_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib ${digitizer_contents_DIR}/plugins/io/libPatternIO.dylib
fi

echo 'copy digitizer qt lib...'
$QTMAC ${pad_dir}/build/release/Digitizer.app

echo '  \033[35m [---------------------------bundle plot------------------------------] \033[0m'

plot_contents_DIR=${pad_dir}/build/release/PlotManager.app/Contents


rm -fr ${pad_dir}/build/release/PlotManager.app
cp -r ${pad_dir}/Utility/Projects/PlotManager/PlotManager_app ${pad_dir}/build/release/PlotManager.app

mkdir ${plot_contents_DIR}/MacOS
mkdir ${plot_contents_DIR}/Frameworks
mkdir ${plot_contents_DIR}/plugins
#copy updater
cp -R ${pad_dir}/build/release/PadUpdater.app ${plot_contents_DIR}/MacOS
#copy lib
cp ${pad_dir}/build/release/PlotManager ${plot_contents_DIR}/MacOS

cp -R ${pad_dir}/build/release/libPadNester*.dylib ${plot_contents_DIR}/Frameworks

cp -R ${pad_dir}/build/release/libPatternGraphic*.dylib ${plot_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPatternConjoin*.dylib ${plot_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libMarkerDB*.dylib ${plot_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPatternDB*.dylib ${plot_contents_DIR}/Frameworks
#copy common lib
cp -R ${pad_dir}/build/release/libPadImpExp*.dylib ${plot_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadCore*.dylib ${plot_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadGeo*.dylib ${plot_contents_DIR}/Frameworks
cp -R ${pad_dir}/build/release/libPadConjoin*.dylib ${plot_contents_DIR}/Frameworks
#copy plot
mkdir ${plot_contents_DIR}/plugins/plot
cp -R ${pad_dir}/build/release/plugins/plot/libPadPlotter*.dylib ${plot_contents_DIR}/plugins/plot
cp -r ${pad_dir}/Common/Projects/PadPlotter/deploy/fonts ${plot_contents_DIR}/plugins/plot
cp -r ${pad_dir}/Common/Projects/PadPlotter/deploy/plotter ${plot_contents_DIR}/plugins/plot
#copy io
mkdir ${plot_contents_DIR}/plugins/io
cp -R ${pad_dir}/build/release/plugins/io/libPatternIO*.dylib ${plot_contents_DIR}/plugins/io
cp -R ${pad_dir}/build/release/plugins/io/libMarkerIO*.dylib ${plot_contents_DIR}/plugins/io

echo 'plot languages'
mkdir ${plot_contents_DIR}/Resources/languages
cp -Rf ../languages/qt*.qm ${plot_contents_DIR}/Resources/languages
cp -Rf ../languages/PlotManager*.qm ${plot_contents_DIR}/Resources/languages
#register qt lib
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${plot_contents_DIR}/Frameworks/libMarkerDB.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/Frameworks/libMarkerDB.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${plot_contents_DIR}/Frameworks/libMarkerDB.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${plot_contents_DIR}/Frameworks/libMarkerDB.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${plot_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${plot_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadNester.dylib ${plot_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${plot_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib ${plot_contents_DIR}/Frameworks/libPatternDB.dylib
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib ${plot_contents_DIR}/Frameworks/libPatternDB.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${plot_contents_DIR}/Frameworks/libPatternConjoin.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${plot_contents_DIR}/Frameworks/libPatternConjoin.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/Frameworks/libPatternConjoin.dylib
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadNester.dylib ${plot_contents_DIR}/Frameworks/libPatternConjoin.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${plot_contents_DIR}/Frameworks/libPatternGraphic.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/Frameworks/libPatternGraphic.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${plot_contents_DIR}/Frameworks/libPatternGraphic.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib ${plot_contents_DIR}/Frameworks/libPatternGraphic.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${plot_contents_DIR}/Frameworks/libPadConjoin.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/Frameworks/libPadConjoin.dylib

install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/Frameworks/libPadCore.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${plot_contents_DIR}/Frameworks/libPadImpExp.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/Frameworks/libPadImpExp.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${plot_contents_DIR}/Frameworks/libPadImpExp.dylib

install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${plot_contents_DIR}/MacOS/PlotManager
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/MacOS/PlotManager
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${plot_contents_DIR}/MacOS/PlotManager
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadNester.dylib ${plot_contents_DIR}/MacOS/PlotManager
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${plot_contents_DIR}/MacOS/PlotManager
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib ${plot_contents_DIR}/MacOS/PlotManager
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib ${plot_contents_DIR}/MacOS/PlotManager
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib ${plot_contents_DIR}/MacOS/PlotManager
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${plot_contents_DIR}/MacOS/PlotManager

if [ -e ${plot_contents_DIR}/plugins/plot/libPadPlotter.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${plot_contents_DIR}/plugins/plot/libPadPlotter.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/plugins/plot/libPadPlotter.dylib

fi

if [ -e ${plot_contents_DIR}/plugins/io/libPatternIO.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${plot_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${plot_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPadNester.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${plot_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPatternDB.1.dylib @executable_path/../Frameworks/libPatternDB.dylib ${plot_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPatternConjoin.1.dylib @executable_path/../Frameworks/libPatternConjoin.dylib ${plot_contents_DIR}/plugins/io/libPatternIO.dylib
install_name_tool -change libPatternGraphic.1.dylib @executable_path/../Frameworks/libPatternGraphic.dylib ${plot_contents_DIR}/plugins/io/libPatternIO.dylib
fi

if [ -e ${plot_contents_DIR}/plugins/io/libMarkerIO.dylib ]; then
install_name_tool -change libPadCore.1.dylib @executable_path/../Frameworks/libPadCore.dylib ${plot_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libPadGeo.1.dylib @executable_path/../Frameworks/libPadGeo.dylib ${plot_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libPadConjoin.1.dylib @executable_path/../Frameworks/libPadConjoin.dylib ${plot_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libPadImpExp.1.dylib @executable_path/../Frameworks/libPadImpExp.dylib ${plot_contents_DIR}/plugins/io/libMarkerIO.dylib
install_name_tool -change libMarkerDB.1.dylib @executable_path/../Frameworks/libMarkerDB.dylib ${plot_contents_DIR}/plugins/io/libMarkerIO.dylib
fi

echo 'copy plot qt lib...'
$QTMAC ${pad_dir}/build/release/PlotManager.app

echo '  \033[35m [-------------------------bundle AutomarkDriver-------------------------] \033[0m'
automark_driver_contents_DIR=${pad_dir}/build/release/PADAutoMarkDriver.app/Contents

rm -fr ${pad_dir}/build/release/PADAutoMarkDriver.app
cp -r ${pad_dir}/Utility/Projects/PADAutoMarkDriver/PADAutoMarkDriver_app ${pad_dir}/build/release/PADAutoMarkDriver.app

mkdir ${automark_driver_contents_DIR}/MacOS
mkdir ${automark_driver_contents_DIR}/Frameworks
mkdir ${automark_driver_contents_DIR}/plugins

cp ${pad_dir}/build/release/PADAutoMarkDriver ${automark_driver_contents_DIR}/MacOS
cp ${pad_dir}/3rdParty/SFN/libs/MAC/shield.dylib ${automark_driver_contents_DIR}/Frameworks

echo 'copy automarkDriver qt lib...'
$QTMAC ${pad_dir}/build/release/PADAutoMarkDriver.app
