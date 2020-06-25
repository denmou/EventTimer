@echo off
@setlocal enableextensions enabledelayedexpansion
set value=
for /r "./resources" %%i in (*) do (
    set value=!value!,%%i
)
set "value=%value:~1%"
echo powershell code
echo ktech --atlas ./images/resources.xml --width 512 --height 256 %value%
pause