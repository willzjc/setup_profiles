@ECHO OFF

REM Locale indepdendent date/month/year parsing

for /F "skip=1 delims=" %%F in ('
    wmic PATH Win32_LocalTime GET Day^,Month^,Year /FORMAT:TABLE
') do (
    for /F "tokens=1-3" %%L in ("%%F") do (
        set CurrDay=0%%L
        set CurrMonth=0%%M
        set CurrYear=%%N
    )
)
set CurrDay=%CurrDay:~-2%
set CurrMonth=%CurrMonth:~-2%

REM echo Current day  :  %CurrDay%
REM echo Current month:  %CurrMonth%
REM echo Current year :%CurrYear%

SET NEW_DIR=C:\local\text\%CurrYear%%CurrMonth%%CurrDay%

IF EXIST %NEW_DIR% (
    ECHO "path exists (%NEW_DIR%)"
) ELSE (
    ECHO "creating %NEW_DIR%"
    MKDIR %NEW_DIR%
)

ECHO "cd %NEW_DIR%"
cd %NEW_DIR%
