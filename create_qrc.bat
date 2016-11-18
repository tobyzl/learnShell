@echo off
set MYDIR=%~p0
set RESDIR=%~1
set RESDIRPATH=%~dp1
set RESDIRNAME=%~nx1
set DEST=%~2
set DESTDIR=%~dp2
set DESTNAME=%~nx2
set PRJNAME=%~3

setlocal disabledelayedexpansion

set QRCFILE=%RESDIRPATH%\%PRJNAME%.qrc
set TMPFILE=%TEMP%\qrc_temp.txt

for /r "%RESDIR%" %%F in (*.bmp *.png *.qml *.xml *.jpg) do (
	"%MYDIR%\test.exe" -s "%DEST%"
	if ERRORLEVEL 1 goto Generate
	"%MYDIR%\test.exe" "%DEST%" -nt "%%~F"
	if ERRORLEVEL 1 goto Generate
)

goto Done

:Generate


del "%QRCFILE%"
echo %RESDIRPATH%> %TMPFILE%
for /f "usebackq delims=" %%i in (`"%MYDIR%\sed.exe" s/[\\\/]/~/g %TMPFILE%`) do set STRIPPATH=%%i

echo Creating %QRCFILE% from pictures in %RESDIR%...
echo ^<?xml version="1.0" encoding="UTF-8"?^>>> "%QRCFILE%"
echo ^<^!DOCTYPE RCC^>>> "%QRCFILE%"
echo ^<RCC^> >> "%QRCFILE%"
echo ^<qresource prefix="/"^>>> "%QRCFILE%"

for /r "%RESDIR%" %%F in (*.bmp *.png *.qml *.xml *.jpg) do (
	echo %%F> %TMPFILE%
	for /f "usebackq delims=" %%i in (`"%MYDIR%\sed.exe" -e s/[\\\/]/~/g -e s/%STRIPPATH%// -e s/~/\//g %TMPFILE%`) do (
	 	echo  ^<file^>%%i^</file^> >> "%QRCFILE%"
	)
)

echo ^</qresource^>>> "%QRCFILE%"
echo ^</RCC^>>> "%QRCFILE%"
echo done

echo Updating %DESTNAME%

"%QT5DIR%\bin\rcc.exe" -name "%RESDIRNAME%" "%QRCFILE%" -o "%DEST%"


:Done

exit /b 0
