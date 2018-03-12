@echo off
setlocal enabledelayedexpansion

for /f "tokens=3" %%i in ('reg.exe query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v DigitalProductId') do (
    set x=%%~i
)

for /l %%z in (104, 2, 132) do (
    set /a array[%%z]=0x!x:~%%z,2!
)

call :GetKey
echo ProductKey: 			%GetKey%

endlocal
exit /b 0

:GetKey
    setlocal enabledelayedexpansion
    set out=%~0
    set pc=BCDFGHJKMPQRTVWXY2346789
    set x=0
    for /l %%i in (0, 1, 28) do (
        if !x! gtr 28 goto :Break

        set a=0

        for /l %%j in (132, -2, 104) do (
            set /a a=array[%%j] + !a! * 256
            set /a array[%%j]="( !a! / 24 ) & 255"
            set /a a%%=24
            set /a n=%%j
        )

        for %%z in (!a!) do set key=!pc:~%%z,1!!key!
        set /a f="( !x! + 2 ) %% 6"

        if !f! equ 0 if !x! lss 28 (
            set /a x+=1
            set key=-!key!
        )

        
        set /a x+=1
    )
:Break
    
    endlocal & set %out:~1%=%key%
    exit /b

	
