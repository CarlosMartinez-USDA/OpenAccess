@echo off
setlocal EnableDelayedExpansion

set "base=%CD%"
set "base=%base:*:=%\"
(
for /R %%a in (*.*) do (
   for /F "tokens=1-5 delims=/-. " %%b in ("%%~Ta") do set "dateTime=%%d-%%c-%%b  %%e%%f"
   set "size=%%~Za"
   set name=%%~PNXa
   echo !dateTime! !size:~-19! !name:%base%=!
)
)>output.txt