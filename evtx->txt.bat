@echo off 

prompt $s 
color 1f 
cd /d "%~dp0" 
title 관리자CMD 
mode con: cols=80 lines=25 

ver | find " 5."  && (cls & echo. & echo  win7부터 적용됩니다 & echo. & pause & exit ) 

>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system" 
if '%errorlevel%' NEQ '0' ( 
    echo 관리 권한을 요청 ... 
    goto UACPrompt 
) else ( goto gotAdmin ) 
:UACPrompt 
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs" 
    set params = %*:"="" 
    echo UAC.ShellExecute "cmd.exe", "/c %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" 

    "%temp%\getadmin.vbs" 
    rem del "%temp%\getadmin.vbs" 
    exit /B 


:gotAdmin 
wevtutil qe C:\Windows\System32\winevt\Logs\system.evtx /lf /f:text  > logsys.txt

:exit 
