@@echo off



rem Hostname change
SET "TextFile=C:\antiOS\host.txt"
FOR /f %%a IN ('type "%textfile%"^|find /c /v ""') DO SET /a numlines=%%a
SET /A RandomLine=(%RANDOM% %% %NumLines%)
IF "%RandomLine%"=="0" (SET "RandomLine=") ELSE (SET "RandomLine=skip=%randomline%")
FOR /F "usebackq tokens=* %RandomLine% delims=" %%A IN (`TYPE %TextFile%`) DO (
    @echo %%A
 set hostname=%%A
    GOTO Finish
)



:Finish
@echo %hostname%

rem Username change
SET "TextFile=C:\antiOS\host.txt"
FOR /f %%a IN ('type "%textfile%"^|find /c /v ""') DO SET /a numlines=%%a
SET /A RandomLine=(%RANDOM% %% %NumLines%)
IF "%RandomLine%"=="0" (SET "RandomLine=") ELSE (SET "RandomLine=skip=%randomline%")
FOR /F "usebackq tokens=* %RandomLine% delims=" %%A IN (`TYPE %TextFile%`) DO (
    @echo %%A
 set user=%%A
    GOTO Finish
)

:Finish
@echo %user%

rem Install date change
set min5=1000
set max5=9999
set /a d1=%random%%%(max5-min5+1)+min5
 
set min6=100
set max6=999
set /a d2=%random%%%(max6-min6+1)+min6
 

rem BuildID
set min1=14190
set max1=14478
set /a bi1=%random%%%(max1-min1+1)+min1

set min2=1078
set max2=1292
set /a bi2=%random%%%(max2-min2+1)+min2

set min3=100
set max3=999
set /a bi3=%random%%%(max3-min3+1)+min3

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
@echo Random string is !_RndAlphaNum!
 
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
@echo Random string is !_RndAlphaNum2!

set I=4
set N=16
set CHAR=0 1 2 3 4 5 6 7 8 9 A B C D E F

set I=4
:LOOP1
set /a R=1+%N%*%random%/32768
for /f "tokens=%R%" %%q in ("%CHAR%") do (set Hex0=%%q%Hex0%)
Set /a I-=1
If %I% GTR 0 goto LOOP1

set I=4
:LOOP2
set /a R=1+%N%*%random%/32768
for /f "tokens=%R%" %%q in ("%CHAR%") do (set Hex1=%%q%Hex1%)
Set /a I-=1
If %I% GTR 0 goto LOOP2

set I=8
:LOOP3
set /a R=1+%N%*%random%/32768
for /f "tokens=%R%" %%q in ("%CHAR%") do (set Hex8=%%q%Hex8%)
Set /a I-=1
If %I% GTR 0 goto LOOP3

set I=10
:LOOP4
set /a R=1+%N%*%random%/32768
for /f "tokens=%R%" %%q in ("%CHAR%") do (set Hex10=%%q%Hex10%)
Set /a I-=1
If %I% GTR 0 goto LOOP4

rem MACadress
SET "TextFile=C:\antiOS\mac.txt"
FOR /f %%a IN ('type "%textfile%"^|find /c /v ""') DO SET /a numlines=%%a
SET /A RandomLine=(%RANDOM% %% %NumLines%)
IF "%RandomLine%"=="0" (SET "RandomLine=") ELSE (SET "RandomLine=skip=%randomline%")
FOR /F "usebackq tokens=* %RandomLine% delims=" %%A IN (`TYPE %TextFile%`) DO (
    @echo %%A
 set mac=%%A
    GOTO Finish
)

:Finish
@echo %mac%

set min3=10
set max3=99
set /a m1=%random%%%(max3-min3+1)+min3

set min3=10
set max3=99
set /a m2=%random%%%(max3-min3+1)+min3

set min3=10
set max3=99
set /a m3=%random%%%(max3-min3+1)+min3

set min4=10000
set max4=32000
set /a m4=%random%%%(max4-min4+1)+min4


rem Hostname/username change
wmic useraccount where caption='%USERNAME%' rename %user%
REG ADD   "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v "NV Hostname" /t REG_SZ /d %hostname% /f
REG ADD   "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\services\Tcpip\Parameters" /v Hostname /t REG_SZ /d %hostname% /f
REG ADD   "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ComputerName" /v ComputerName /t REG_SZ /d %hostname% /f
REG ADD   "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\ComputerName\ActiveComputerName" /v ComputerName /t REG_SZ /d %hostname% /f
REG ADD   "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v RegisteredOwner /t REG_SZ /d %user% /f

rem Windows PID change
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductId /t REG_SZ /d 00331-%m4%-00001-A!_RndAlphaNum2! /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId /t REG_BINARY  /d A40000000%i3%00003030%i4%312D3836382D303030303030372D383535353700AA0000005831352D333%i5%3000000000000000C3AABF%Hex0%BA18B8878E89D%Hex0%000000000000396CC459B%i5%D0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000%Hex1%6736 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId4 /t REG_BINARY  /d %Hex8%0400000030003000330037%Hex1%002D00300030003100370030002D003800360038002D003000300030003000300030002D00300033002D0031003000330033002D0037003600300031002E0030003000300030002D003200360035003200300031003700000000000000000000000000000000000000000000000000000000000000000062003900320065003%Hex8%80030002D0062003900%i3%035002D0034003800320031002D0039006300390034002D003100340030006600360033003200660036003300310032000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000005000%i4%6F0066006500730073006%Hex1%F006E0061006C00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C3AABFA65BBA18B8%i4%89D24ED80000C61%Hex8%D0BEDFD25E%Hex1%45B89FFF45564B8%i4%4E87CB968EC7F4D18F6E5066261A0B704B9D2739558B7E97DF882AB087AB0D8A314BA9BB1E06029EA28D5800310035002D0033003900310037003000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000056006F006C0075006D006%i4%A00470056004C004B000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000056006F006C007%i4%D0065000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000 /f
rem InternetExplorer PID change
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Registration" /v ProductId /t REG_SZ /d 00331-10000-00001-A!_RndAlphaNum2! /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer" /v svcKBNumber /t REG_SZ /d KB3170%d2% /f

rem Install date change
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v InstallDate /t REG_DWORD /d 150%d2%%d1% /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Migration" /v "IE Installed Date" /t REG_BINARY /d 150%d2%%d1% /f

rem Hardware GUID change
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\IDConfigDB\Hardware Profiles\0001" /v HwProfileGuid /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-80%Hex10%} /f

rem Device GUID (individual for all sysmems)
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e965-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v PropertyGuid /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-6a%Hex10%} /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e967-e325-11ce-bfc1-08002be10318}\Configuration\Variables\BusDeviceDesc" /v PropertyGuid /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-6a%Hex10%} /f
rem REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\DeviceDesc" /v PropertyGuid /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-67%Hex10%} /f
rem REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Class\{4d36e968-e325-11ce-bfc1-08002be10318}\Configuration\Variables\Driver" /v PropertyGuid /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-67%Hex10%} /f
rem REG ADD "HKEY_LOCAL_MACH

rem CKCL GUID
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\BootCKCLSettings" /v GUID /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-3e%Hex10%} /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\SecondaryLogonCKCLSettings" /v GUID /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-3e%Hex10%} /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\Diagnostics\Performance\ShutdownCKCLSettings" /v GUID /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-3e%Hex10%} /f

rem Hardware profile GUID
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\IDConfigDB\Hardware Profiles\0001" /v HwProfileGuid /t REG_SZ /d {%Hex8%-%Hex1%-%Hex0%-%Hex1%-80%Hex10%} /f

rem Crypto Machine GUID change
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Cryptography" /v MachineGuid /t REG_SZ /d %Hex8%-%Hex1%-%Hex0%-%Hex1%-e7%Hex10% /f

rem Version number change
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild /t REG_SZ /d %bi1% /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuildNumber /t REG_SZ /d %bi1% /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v BuildLab /t REG_SZ /d %bi1%.rs1_release.17%bi2%-2100 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v BuildLabEx /t REG_SZ /d %bi1%.1944.amd64fre.rs1_release.17%bi2%-2100 /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v BuildGUID /t REG_SZ /d %Hex8%-%Hex1%-%Hex0%-%Hex1%-%Hex10% /f

rem STI change
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\StillImage\Events\Connected" /v GUID /t REG_SZ /d {A28BBADE-%Hex1%-%Hex0%-%Hex1%-00%Hex10%} /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\StillImage\Events\Disconnected" /v GUID /t REG_SZ /d {143E4E83-%Hex1%-%Hex0%-%Hex1%-00%Hex10%} /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\StillImage\Events\EmailImage" /v GUID /t REG_SZ /d {C66DCEE1-%Hex1%-%Hex0%-%Hex1%-2F%Hex10%} /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\StillImage\Events\FaxImage" /v GUID /t REG_SZ /d {C00EB793-%Hex1%-%Hex0%-%Hex1%-00%Hex10%} /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\StillImage\Events\PrintImage" /v GUID /t REG_SZ /d {B441F425-%Hex1%-%Hex0%-%Hex1%-00%Hex10%} /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\StillImage\Events\ScanButton" /v GUID /t REG_SZ /d {A6C5A715-%Hex1%-%Hex0%-%Hex1%-00%Hex10%} /f
REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\StillImage\Events\STIproxyEvent" /v GUID /t REG_SZ /d {d711f81f-%Hex1%-%Hex0%-%Hex1%-92%Hex10%} /f

rem Windows WMI Guid (individual for each system)
rem REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Control\WMI\Autologger\AppModel" /v GUID /t REG_SZ /d {A922A8BE-%Hex1%-%Hex0%-%Hex1%-92%Hex10%} /f

rem Enum ID (individual for each system)
rem REG ADD "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Enum\ACPI"

rem EDGE (individual for each system)
rem HKEY_USERS\SID\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ExtensionsStore\datastore\usage\dscc_inventory\ExtensionInventoryVersionGUID_DONOTUSEINSTORE
REG ADD "HKEY_CURRENT_USER\Software\Classes\Local Settings\Software\Microsoft\Windows\CurrentVersion\AppContainer\Storage\microsoft.microsoftedge_8wekyb3d8bbwe\MicrosoftEdge\ExtensionsStore\datastore\usage\dscc_inventory\ExtensionInventoryVersionGUID_DONOTUSEINSTORE" /v value /t REG_SZ /d {27720B92-%Hex1%-%Hex0%-%Hex1%-92%Hex10%} /f


rem WSUS change
net stop wuauserv
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientId /t REG_SZ /d %Hex8%-%Hex1%-%Hex0%-%Hex1%-c9%Hex10% /f  
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\WindowsUpdate" /v SusClientIDValidation /t REG_BINARY /d A40000000%i3%00003030%i4%312D3836382D30303%Hex10%D383535353700AA0000005831352D333%i5%3000000000000000C3AABF%Hex0%BA18B8878E89D%Hex0%000000000000396CC459B%i5%D0300000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000%Hex1%6736 /f 
net start wuauserv 

rem SID\Network Adapter GUID\DTC\DHCPv6 (CHANGE PATH TO SOFTWARE SIDCHG http:\\www.stratesave.com\html\sidchg.html)
C:\sidchg64 /F /R /KEY

rem VolumeID change
C:\antiOS\Volumeid64.exe C: !_RndAlphaNum!0-!_RndAlphaNum2!

rem MAC address change
REG ADD "HKLM\SYSTEM\CurrentControlSet\Control\Class\{4D36E972-E325-11CE-BFC1-08002BE10318}\0007" /v	NetworkAddress		    /d %mac%%m1%%m2%%m3% /f	

cls
@echo off
@echo   -----================================================================================------
    @echo.
    @echo               Change the Windows unique user ID - Batch file script v1.0
    @echo.                     Copyright (c) by Vektor T13 - http://antidetect.online
    @echo.
    @echo                       Join the project Antidetect - be elusive!
    @echo.
	@echo   -----================================================================================------
	@echo.
	@echo Your new Windows ID
	@echo Username:			%user% 
	@echo Hostname:			%hostname% 
	@echo CurrentBuild:			%bi1% 
	@echo CurrentBuildNumber:		%bi1% 
	@echo BuildLab:			%bi1%.rs1_release.17%bi2%-2100 
	@echo BuildLabEx:			%bi1%.1944.amd64fre.rs1_release.17%bi2%-2100
	@echo BuildGuid:			%Hex8%-%Hex1%-%Hex0%-%Hex1%-%Hex10%
	@echo CryptoMachineGuid:		%Hex8%-%Hex1%-%Hex0%-%Hex1%-e7%Hex10%
	@echo DeviceGuid:			{%Hex8%-%Hex1%-%Hex0%-%Hex1%-6a%Hex10%}
	@echo CKCL Guid:			{%Hex8%-%Hex1%-%Hex0%-%Hex1%-3e%Hex10%}
	@echo HardwareProfileGuid:		{%Hex8%-%Hex1%-%Hex0%-%Hex1%-80%Hex10%}
	@echo WMIGuid:			{A922A8BE-%Hex1%-%Hex0%-%Hex1%-92%Hex10%}
	@echo EDGE Guid:			{27720B92-%Hex1%-%Hex0%-%Hex1%-92%Hex10%}
	@echo InstallDate:			150%d2%%d1%
	@echo ProductID:			00331-%m4%-00001-A!_RndAlphaNum2!
	call productkey.bat
	@echo WindowsUpdateClientID:		%Hex8%-%Hex1%-%Hex0%-%Hex1%-c9%Hex10%
	@echo SID:
	@echo ********************************************************
	@echo STI
	@echo Connected:			{A28BBADE-%Hex1%-%Hex0%-%Hex1%-00%Hex10%}
	@echo Disconnected:			{143E4E83-%Hex1%-%Hex0%-%Hex1%-00%Hex10%}
	@echo Email:				{C66DCEE-%Hex1%-%Hex0%-%Hex1%-2F%Hex10%}
	@echo Fax:				{C00EB793-%Hex1%-%Hex0%-%Hex1%-00%Hex10%}
	@echo Print:				{B441F425-%Hex1%-%Hex0%-%Hex1%-00%Hex10%}
	@echo Scan:				{A6C5A715-%Hex1%-%Hex0%-%Hex1%-00%Hex10%}
	@echo STIproxyEvent:			{d711f81f-%Hex1%-%Hex0%-%Hex1%-92%Hex10%}
	@echo ********************************************************
	@echo Your new InternetExplorer ID
	@echo ProductID:			00331-10000-00001-A!_RndAlphaNum2!
	@echo KBNumber:			KB3170%d2%
	@echo Install date:			150%d2%%d1%
	@echo ********************************************************
	@echo Your new Hardware ID
	@echo VolumeID:			!_RndAlphaNum!-!_RndAlphaNum2!
	@echo MACadress:			%mac%%m1%%m2%%m3%
	@echo HardwareGUID:			%Hex8%-%Hex1%-%Hex0%-%Hex1%-80%Hex10%
	@echo NetworkAdapterGUID:
	
pause
