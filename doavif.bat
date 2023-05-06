
REM batch script to convert to avif
REM Mathews Sunny

ECHO OFF
CLS

ECHO.
ECHO ...............................................
ECHO .      JPG to AVIF conversion (npx avif)
ECHO ...............................................
ECHO  by Mathews Sunny

CALL :LISTFILES
ECHO ...............................................

SET /P M=Enter y to proceed(y/n):
IF %M%==y (
  CALL :CONVERT2AVIF
  CALL :DELETE
) ELSE ECHO Execution cancelled. 
GOTO EOF

rem sub ------------------------------------------------------------------------------
:CONVERT2AVIF
ECHO Starting conversion.
START "avifrun" /W /LOW /B cmd /c npx avif 
ECHO Finished converting to AVIF. 
CALL :LISTFILES
ECHO ...............................................
EXIT /B
rem end sub ------------------------------------------------------------------------------

rem sub ------------------------------------------------------------------------------
:DELETE
SET /P M=Do you want to delete all JPG files? Enter 'delete' to proceed:
IF %M%==delete (
  CALL saferdelete *.jpg
  ECHO JPG file delete run. 
  CALL :LISTFILES
  ECHO ...............................................
) ELSE ECHO Exiting without deletion.
EXIT /B
rem end sub ------------------------------------------------------------------------------

rem sub ------------------------------------------------------------------------------
:LISTFILES
set jpgcount=0
set jpgsize=0
set avifcount=0
set avifsize=0
FOR /F "delims=" %%X IN ('DIR /B/A-D *.jpg') DO (
  SET /A "jpgcount+=1"
  SET /A "jpgsize+=%%~zX/1024"
)
FOR /F "delims=" %%X IN ('DIR /B/A-D *.avif') DO (
  SET /A "avifcount+=1"
  SET /A "avifsize+=%%~zX/1024"
)

SET /A "jpgsizemb=%jpgsize%/1024"
SET /A "avifsizemb=%avifsize%/1024"
ECHO.
ECHO In "%cd%"
ECHO %jpgcount% jpg files %jpgsizemb% MB
ECHO %avifcount% avif files %avifsizemb% MB
ECHO.

SET /A "avifsavings=(%jpgsize%-%avifsize%)/1024"
rem ECHO sizes: %jpgsize%, %avifsize%, %avifsavings%

IF %jpgcount% EQU %avifcount% (
IF %jpgsize% NEQ 0 (
  SET /A "avifpercent=100*%avifsize%/%jpgsize%"
  ECHO Total AVIF size is %avifpercent% percent of JPG. Savings of %avifsavings% MB. 
  ECHO.
)
)
EXIT /B
rem end sub -------------------------------------------------------------------------

:EOF


