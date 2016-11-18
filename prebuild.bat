@echo off
set MYDIR=%~p0
set PROJECTNAME=%~1
set PROJECTDIR=%~2
set INTDIR=%~3

set CONFIGURATION=Debug

if not "%INTDIR:Release=%"=="%INTDIR%" (
	set CONFIGURATION=Release
)

echo %MYDIR%
echo %PROJECTNAME%
echo %PROJECTDIR%
echo %INTDIR%

::::::::::::::::::::::::::::::::::::::::::::::
:: build images resource
rem if exist "%PROJECTDIR%\Projects\%PROJECTNAME%\images" del "%PROJECTDIR%\Projects\%PROJECTNAME%\resource\qrc_images.cpp"
rem if exist "%PROJECTDIR%\Projects\%PROJECTNAME%\qml" del "%PROJECTDIR%\Projects\%PROJECTNAME%\resource\qrc_qml.cpp"
rem if exist "%PROJECTDIR%\Projects\%PROJECTNAME%\widgets" del"%PROJECTDIR%\Projects\%PROJECTNAME%\resource\qrc_widgets.cpp"

if exist "%PROJECTDIR%\Projects\%PROJECTNAME%\images" call "%MYDIR%\create_qrc.bat" "%PROJECTDIR%\Projects\%PROJECTNAME%\images" "%PROJECTDIR%\Projects\%PROJECTNAME%\resource\qrc_images.cpp" "%PROJECTNAME%"
if exist "%PROJECTDIR%\Projects\%PROJECTNAME%\qml" call "%MYDIR%\create_qrc.bat" "%PROJECTDIR%\Projects\%PROJECTNAME%\qml" "%PROJECTDIR%\Projects\%PROJECTNAME%\resource\qrc_qml.cpp" "%PROJECTNAME%"
if exist "%PROJECTDIR%\Projects\%PROJECTNAME%\widgets" call "%MYDIR%\create_qrc.bat" "%PROJECTDIR%\Projects\%PROJECTNAME%\widgets" "%PROJECTDIR%\Projects\%PROJECTNAME%\resource\qrc_widgets.cpp" "%PROJECTNAME%"
::::::::::::::::::::::::::::::::::::::::::::::

::::::::::::::::::::::::::::::::::::::::::::::
:: build meta objects and dialogs
if not exist "%INTDIR%\moc" md "%INTDIR%\moc"
if exist %PROJECTDIR%\Include\%PROJECTNAME% (
	call "%MYDIR%\moc_files.bat" %PROJECTDIR%\Include\%PROJECTNAME% "%INTDIR%\moc"
) 
if exist %PROJECTDIR%\Source\%PROJECTNAME% (
call "%MYDIR%\moc_files.bat" %PROJECTDIR%\Source\%PROJECTNAME% "%INTDIR%\moc"
)
if exist "%PROJECTDIR%\Projects\%PROJECTNAME%\dialogs" call "%MYDIR%\uic_files.bat" "%PROJECTDIR%\Projects\%PROJECTNAME%\dialogs" "%INTDIR%\moc"
::::::::::::::::::::::::::::::::::::::::::::::

exit /b 0
