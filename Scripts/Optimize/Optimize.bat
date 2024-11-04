@echo off

:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------    
    <YOUR BATCH SCRIPT HERE>@echo off


ping 127.0.0.1 -n 3 > nul
taskkill /F /IM OfficeClickToRun.exe >nul 2>&1
sc stop GigabyteUpdateService
sc stop SDXHelper

@echo off
setlocal

rem Stop the ClickToRunSvc service
net stop ClickToRunSvc

endlocal


taskkill /F /IM OfficeClickToRun.exe >nul 2>&1

taskkill /F /IM OfficeClickToRun.exe >nul 2>&1
taskkill /F /IM MicrosoftEdgeUpdate.exe >nul 2>&1
taskkill /F /IM BGAUpsell.exe >nul 2>&1
taskkill /F /IM WidgetService.exe >nul 2>&1
taskkill /F /IM backgroundTaskHost.exe >nul 2>&1
taskkill /F /IM Widgets.exe >nul 2>&1
taskkill /F /IM MoUsoCoreWorker.exe >nul 2>&1
taskkill /F /IM GoogleCrashHandler.exe >nul 2>&1
taskkill /F /IM GoogleCrashHandler64.exe >nul 2>&1
taskkill /F /IM SDXHelper.exe >nul 2>&1
taskkill /F /IM WhatsApp.exe >nul 2>&1
taskkill /F /IM wps.exe >nul 2>&1
taskkill /F /IM wpscenter.exe >nul 2>&1
taskkill /F /IM wpscloudsvr.exe >nul 2>&1
taskkill /F /IM wslservice.exe >nul 2>&1

@echo off

del /s /f /q c:\windows\temp\*.*
del /s /f /q C:\WINDOWS\Prefetch
del /s /f /q %temp%\*.*
deltree /y c:\windows\tempor~1
deltree /y c:\windows\temp
deltree /y c:\windows\tmp
deltree /y c:\windows\ff*.tmp
deltree /y c:\windows\history
deltree /y c:\windows\cookies
deltree /y c:\windows\recent
deltree /y c:\windows\spool\printers
cls.exe

echo Deleting files from %temp% folder...
cd %temp%
del /F /Q *.*
echo Done!

echo Deleting files from %temp% and temp folders...


echo Running as Administrator...
echo Please provide administrator credentials if prompted.


pushd %temp%
takeown /r /d y /f *
icacls * /grant administrators:F /t
del /q /f /s *
popd

pushd %systemroot%\temp
takeown /r /d y /f *
icacls * /grant administrators:F /t
del /q /f /s *
popd

@echo off
echo Deleting unnecessary files from Temp folders...
del /s /q %SystemRoot%\Temp\*.*
del /s /q %UserProfile%\AppData\Local\Temp\*.*
echo Completed. Press any key to close.
rd %temp% /s /q
rd temp /s /q

md %temp%

net start w32time
w32tm /resync
net stop w32time

exit

