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

sc config WlanSvc start=disabled
sc config SDRSVC start=disabled
sc config OneSyncSvc_47716 start=disabled
sc config Spooler start=disabled
sc config WSLService start=manual
sc config ProtonVPN WireGuard start=manual
sc config ProtonVPN Service start=manual
sc config wpscloudsvr start=disabled
sc config wuauserv start=disabled
sc config TermService start=manual
sc config XboxGipSvc start=disabled
sc config DusmSvc start=disabled
REM Disabling Telephone Service
sc config TapiSrv start=disabled
REM Disabling Microsoft Edge Update Service
sc config edgeupdate start=manual
REM Disabling Microsoft Edge Elevation Service
sc config edgeupdatem start=disabled
REM Optimize Drives service
sc config defragsvc start= demand
REM Distributed Link Tracking Client
sc config TrkWks start= disabled
REM Application Layer Gateway Service
sc config ALG start=disabled
REM AllJoyn Router Service
sc config AJRouter start=disabled
REM Xbox Live Auth Manager
sc config XblAuthManager start=disabled
REM Xbox Live Game Save
sc config XblGameSave start=disabled
REM Xbox Live Networking Service
sc config XboxNetApiSvc start=disabled
REM Geolocation Service
sc config lfsvc start=disabled
REM Remote Registry
sc config RemoteRegistry start=disabled
REM Parental Control
sc config 	WpcMonSvc start=disabled
REM Payments and NFC/SE Manager
sc config SEMgrSvc start=disabled
REM Smartcard
sc config SCardSvr start=disabled
REM Netlogon
sc config Netlogon start=disabled	
REM Offline Files
sc config 	CscService start=disabled
REM Windows Mobile Hotspot Service
sc config icssvc start=disabled
REM Windows Insider Service
sc config wisvc start=disabled
REM Retail Demo Service
sc config RetailDemo start=disabled
REM WalletService
sc config WalletService start=disabled
REM Fax
sc config Fax start=disabled
REM Windows Biometric Service
sc config WbioSrvc start=disabled
REM IP Helper
sc config iphlpsvc start=disabled
REM Windows Connect Now
sc config wcncsvc start=disabled
REM File History Service	
sc config fhsvc start=disabled
REM Phone Service
sc config PhoneSvc start=disabled
REM Secondary Logon
sc config seclogon start=disabled
REM Windows Camera Frame Server
sc config FrameServer start=disabled
REM Windows Biometric Service
sc config WbioSrvc start=disabled
REM Windows Image Acquisition
sc config StiSvc start=disabled
REM Program Compatibility Assistant Service
sc config PcaSvc start=disabled
REM Diagnostic Policy Service
sc config DPS start=disabled
REM Download Maps Manager
sc config MapsBroker start=disabled
REM Bluetooth Support Service
sc config bthserv start=disabled
REM Bitlocker
sc config BDESVC start=disabled
REM AVCTP Service
sc config BthAvctpSvc start=disabled	
REM Parental Control
sc config WpcMonSvc start=disabled
REM Connected User Experience and Telemetry
sc config DiagTrack start=disabled
REM Certificate Propagation
sc config CertPropSvc start=disabled	
REM Diagnostic Service Host
sc config WdiServiceHost start=disabled
REM TCP/IP NetBIOS Helper
sc config lmhosts start=disabled
REM Diagnostic System Host
sc config WdiSystemHost start=disabled
REM Distributed Link Tracking Client
sc configTrkWks start=disabled
REM Windows Error Reporting Service
sc config WerSvc start=disabled
REM Touch Keyboard and Handwriting Panel Service
sc config TabletInputService start=disabled                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           