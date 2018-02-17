@echo on

rem Hostname change
set min=100
set max=32000
set /a newname=%random%%%(max-min+1)+min
FOR /F "usebackq" %%a IN (`hostname`) DO (
    set resultPname=%%a
)
echo %resultPname%

rem Install date change
set min5=1000
set max5=9999
set /a d1=%random%%%(max5-min5+1)+min5
 
set min6=100
set max6=999
set /a d2=%random%%%(max6-min6+1)+min6
 
set min=100
set max=32000
set /a newname=%random%%%(max-min+1)+min

rem BuildID
set min1=14190
set max1=14478
set /a bi1=%random%%%(max1-min1+1)+min1

set min2=1078
set max2=1292
set /a bi2=%random%%%(max2-min2+1)+min2

rem VolumeID
Setlocal EnableDelayedExpansion
Set _RNDLength=4
Set _Alphanumeric=ABCDEF0123456789
Set _Str=%_Alphanumeric%987654321
:_LenLoop
IF NOT "%_Str:~18%"=="" SET _Str=%_Str:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%_Str:~9,1%
SET /A _Len=_Len+_tmp
Set _count=0
SET _RndAlphaNum=
:_loop
Set /a _count+=1
SET _RND=%Random%
Set /A _RND=_RND%%%_Len%
SET _RndAlphaNum=!_RndAlphaNum!!_Alphanumeric:~%_RND%,1!
If !_count! lss %_RNDLength% goto _loop
Echo Random string is !_RndAlphaNum!
 
Setlocal EnableDelayedExpansion
Set _RNDLength=4
Set _Alphanumeric=ABCDEF0123456789
Set _Str=%_Alphanumeric%987654321
:_LenLoop
IF NOT "%_Str:~18%"=="" SET _Str=%_Str:~9%& SET /A _Len+=9& GOTO :_LenLoop
SET _tmp=%_Str:~9,1%
SET /A _Len=_Len+_tmp
Set _count=0
SET _RndAlphaNum2=
:_loop
Set /a _count2+=1
SET _RND=%Random%
Set /A _RND=_RND%%%_Len%
SET _RndAlphaNum2=!_RndAlphaNum2!!_Alphanumeric:~%_RND%,1!
If !_count2! lss %_RNDLength% goto _loop
Echo Random string is !_RndAlphaNum2!



rem Hostname change
wmic computersystem where caption='%resultPname%' rename User%newname%

rem User rename
rem wmic useraccount where name=‘Текущее имя' rename Новое имя

rem Windows PID change
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductId /t REG_SZ /d 00331-10000-00001-A!_RndAlphaNum2! /f

rem InternetExplorer PID change
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Registration" /v ProductId /t REG_SZ /d 00331-10000-00001-A!_RndAlphaNum2! /f

rem Install date change
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v InstallDate /t REG_DWORD /d 150%d2%%d1% /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Migration" /v Ie Installed Date /t REG_BINARY /d 150%d2%%d1% /f

rem Version number change
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild /t REG_SZ /d %bi1% /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuildNumber /t REG_SZ /d %bi1% /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v BuildLab /t REG_SZ /d %bi1%.rs1_release.17%bi2%-2100 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v BuildLabEx /t REG_SZ /d %bi1%.1944.amd64fre.rs1_release.17%bi2%-2100 /f

rem SID\WSUS\PC GUID\Network Adapter GUID\DTC\DHCPv6 (CHANGE PATH TO SOFTWARE SIDCHG http:\\www.stratesave.com\html\sidchg.html)
C:\Folder\sidchg64 \F \R

rem VolumeID change (CHANGE PATH TO SOFTWARE volmeid https:\\technet.microsoft.com\ru-ru\sysinternals\bb897436.aspx)
C:\Volumeid64.exe C: !_RndAlphaNum!-!_RndAlphaNum2!

rem MAC address change (CHANGE PATH TO SOFTWARE TMac https:\\technitium.com\tmac\)
"C:\Program Files (x86)\Technitium\TMACv6.0\TMAC.exe" -n "Ethernet" -r -re

pause
