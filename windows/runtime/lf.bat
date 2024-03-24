@ECHO OFF
REM Creates a new folder with yyyymmdd as the name at a specific base location
REM Format is "%date%" = "Tue 22/12/2020"
SET BASE_PATH=C:\local\text
SET TARGET=%BASE_PATH%\%date:~10,4%%date:~7,2%%date:~4,2%
ECHO TARGET=%TARGET%

IF EXIST "%TARGET%\" (
 ECHO %TARGET% Already exists, not creating
) ELSE (
 ECHO %TARGET% does not exist
 MKDIR %TARGET%
)

explorer %TARGET%
