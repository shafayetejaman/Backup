<# : batch script
@echo off
setlocal
cd %~dp0
powershell -executionpolicy remotesigned -Command "Invoke-Expression $([System.IO.File]::ReadAllText('%~f0'))"
endlocal
goto:eof
#>
# here write your powershell commands...


iwr -useb https://christitus.com/win | iex

