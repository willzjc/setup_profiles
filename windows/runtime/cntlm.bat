@ECHO OFF

:START
WMIC path win32_process get Caption,Processid,Commandline | grep "cntlm" | grep -v grep | grep -v cntlm.bat | gawk "{print $6}" > C:/local/code/proxytest/currentpid.log
SET /p CURRENTPID=< C:/local/code/proxytest/currentpid.log
TASKKILL /F /PID %CURRENTPID%

WMIC path win32_process get Caption,Processid,Commandline | grep "cntlm.exe" | grep -v grep | grep -v cntlm.bat | gawk "{print $6}" > C:/local/code/proxytest/currentpid.log
SET /p CURRENTPID=< C:/local/code/proxytest/currentpid.log
TASKKILL /F /PID %CURRENTPID%

SET ip_address_string="IPv4 Address"
REM Uncomment the following line when using older versions of Windows without IPv6 support (by REMoving "REM")
REM SET ip_address_string="IP Address"

SET ISPROXY=-1

:LOOP

FOR /f "usebackq tokens=2 delims=:" %%f in (`ipconfig ^| findstr /c:%ip_address_string%`) DO (
    REM ECHO Your IP Address is: %%f
    SET IPVAR=START%%f
    GOTO :RESULTS
)

GOTO LOOP

:RESULTS
    REM ECHO %IPVAR%
    ECHO %IPVAR% > "C:/local/code/proxytest/currentip.log"
    find /c "START 10."  C:/local/code/proxytest/currentip.log
    REM echo "done searching"
    echo %IPVAR% | find "10.0.0" > nul
    if %ISPROXY%==-1 (
        if %errorlevel%==0 (
            echo Direct IP found %IPVAR%
            set ISPROXY=0
            GOTO :CNTLMDIRECT
        ) else (
            echo Proxy IP found %IPVAR%
            set ISPROXY=1
            GOTO :CTNLMPROXY     
        )
    ) else (
        if %errorlevel%==0 (
            if %ISPROXY%==1 (
                echo Direct IP found AFTER being proxy %IPVAR% 
                GOTO :START
            )
        ) else (
            if %ISPROXY%==0 (
                echo Proxy IP found AFTER being direct %IPVAR%
                set ISPROXY=1
                GOTO :START
            )
        )
    )
    echo sleeping 5 seconds [no change detected]
    timeout 5
    
    goto :LOOP

:CTNLMPROXY
START /B C:/local/app/Cntlm/cntlm.exe -c C:/local/app/Cntlm/cntlmproxy.ini -v
GOTO :LOOP

:CNTLMDIRECT
START /B C:/local/app/Cntlm/cntlm.exe -c C:/local/app/Cntlm/cntlm.ini -v
GOTO :LOOP
