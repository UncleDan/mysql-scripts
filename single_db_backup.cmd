@rem -- set variables
set MYFILENAME=fulldump
set MYDESTINATIONFOLDER=C:\Users\Public\single\backup
set MYSQLPATH=C:\mysql\bin
set MYDBNAME=single_db
set MYDBUSER=single_user
set MYDBPW=123
set P7ZIPPATH=C:\Program Files\7-Zip

@rem -- process date from http://stackoverflow.com/questions/1192476/format-date-and-time-in-a-windows-batch-script
set hour=%time:~0,2%
if "%hour:~0,1%" == " " set hour=0%hour:~1,1%
@rem echo hour=%hour%
set min=%time:~3,2%
if "%min:~0,1%" == " " set min=0%min:~1,1%
@rem echo min=%min%
set secs=%time:~6,2%
if "%secs:~0,1%" == " " set secs=0%secs:~1,1%
@rem echo secs=%secs%

set year=%date:~-4%
@rem echo year=%year%
set month=%date:~3,2%
if "%month:~0,1%" == " " set month=0%month:~1,1%
@rem echo month=%month%
set day=%date:~0,2%
if "%day:~0,1%" == " " set day=0%day:~1,1%
@rem echo day=%day%

set datetimef=%year%%month%%day%_%hour%%min%%secs%

@rem -- process dump
"%MYSQLPATH%\mysqldump.exe" -u %MYDBUSER% -p%MYDBPW% %MYDBNAME% > "%MYDESTINATIONFOLDER%\%MYFILENAME%_%datetimef%.txt"

@rem --compress
@echo.
"%P7ZIPPATH%\7z.exe" a -sdel "%MYDESTINATIONFOLDER%\%MYFILENAME%_%datetimef%.zip" "%MYDESTINATIONFOLDER%\%MYFILENAME%_%datetimef%.txt"
echo Compressione file...

@rem -- tell you have finished
@echo.
@echo Backup terminato.

@rem -- give time to read
@rem pause


@rem -- release variables
set MYFILENAME=
set MYDESTINATIONFOLDER=
set MYSQLPATH=
set MYDBNAME=
set MYDBUSER=
set MYDBPW=
set P7ZIPPATH=
