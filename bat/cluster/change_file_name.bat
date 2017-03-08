@echo off


for %%i in (*.jpg*) do (
    echo %%i
    ren "%%i" "%%i"
)


pause