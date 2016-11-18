@echo off
setlocal EnableDelayedExpansion
cd "%~dp0"
set tools_path=%cd%
cd ../

set item=images qml widgets
rem find all projects in PADShare
for /d /r %%f in (*projects) do (
    if /i "%%~nxf" equ "projects" (
	    cd %%f
		rem fined all fileNames in projects
		for /f "delims=" %%a in ('dir /ad/b') do (
		    rem find files which contains images or qml or widgets
			for %%i in (%item%) do (
			    if exist "%%a\%%i" (
			       	del "%%a\resource\qrc_%%i.cpp"
				   call "%tools_path%\create_qrc.bat" "%%f\%%a\%%i" "%%f\%%a\resource\qrc_%%i.cpp" "%%a"
                )
			)   
		)
    )
)

pause

