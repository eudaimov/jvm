@echo off

set "script_dir=%~dp0"

if "%1"=="" (
    set param1=""
) else (
    set param1=%1
)

if "%2"=="" (
    set param2=""
) else (
    set param2=%2
)

powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%script_dir%jvm.ps1" -FirstParam %param1% -SecondParam %param2%

