REM start vcxsrv without access control
C:\local\app\vcxsrv\vcxsrv.exe -ac -clipboard -wgl -multiwindow

REM run env vars without any gui pathway
rundll32 sysdm.cpl,EditEnvironmentVariables

REM run system properties?
"C:\WINDOWS\system32\rundll32.exe" shell32.dll,Control_RunDLL sysdm.cpl,,3
