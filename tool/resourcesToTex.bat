@echo off
@setlocal enableextensions enabledelayedexpansion
set value=
for /r "../resources" %%i in (*) do (
    set value=!value!,%%i
)
set "value=%value:~1%"
echo powershell code
echo ktech --atlas ./resources.xml --extend %value%
pause