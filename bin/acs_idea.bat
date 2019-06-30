@echo off
if "%OS%" == "Windows_NT" setlocal enableextensions enabledelayedexpansion

rem Check for Help command 

set ARGV=.%*

call :parse_argv
if ERRORLEVEL 1 (
  echo Cannot parse arguments
  endlocal
  exit /B 1
)

set GRADLE_PARAMS= cleanidea idea

if /I !ARGC! == 0 goto :execmd

if /I !ARGC! == 1 (	
  if %1 ==  -?     goto :showhelp
  if %1 ==  -h     goto :showhelp
  if %1 ==  -help  goto :showhelp
  if %1 ==  --help goto :showhelp
  if %1 ==  help   goto :showhelp
  exit /b 1
)

set ARGI = 0
echo.
:loopstart
set /a ARGI = !ARGI! + 1
set /a ARGN = !ARGI! + 1

if !ARGI! gtr %ARGC% goto loopend

call :getarg !ARGI! ARG
call :getarg !ARGN! ARGNEXT

	if /I "%ARG%"=="--compile" (
		set GRADLE_PARAMS=%GRADLE_PARAMS% build
		set DEPLOY_PROFILE=%ARGNEXT%
		set /a ARGI = !ARGI! + 1
		goto loopstart
	) else (
	  	if /I "%ARG%"=="-c" (
				set GRADLE_PARAMS=%GRADLE_PARAMS% build
				set DEPLOY_PROFILE=%ARGNEXT%
      	set /a ARGI = !ARGI! + 1
      	goto loopstart 
     ) else (	
	if /I "%ARG%"=="--install" (
		set GRADLE_PARAMS=%GRADLE_PARAMS% 
		set DEPLOY_PROFILE=%ARGNEXT%
		set /a ARGI = !ARGI! + 1
		goto loopstart
	) else (
	  	if /I "%ARG%"=="-i" (
				set GRADLE_PARAMS=%GRADLE_PARAMS% 
				set DEPLOY_PROFILE=%ARGNEXT%
      	set /a ARGI = !ARGI! + 1
      	goto loopstart 
     ) else (
    if /I "%ARG%"=="--nomal" (
			set GRADLE_PARAMS=%GRADLE_PARAMS%
			set DEPLOY_PROFILE=%ARGNEXT%
		set /a ARGI = !ARGI! + 1
		goto loopstart
	) else (
	  	if /I "%ARG%"=="-n" (
				set GRADLE_PARAMS=%GRADLE_PARAMS%
				set DEPLOY_PROFILE=%ARGNEXT%
      	set /a ARGI = !ARGI! + 1
      	goto loopstart 
     ) else (	
	if /I "%ARG%"=="--buildJs" (
			set GRADLE_PARAMS=%GRADLE_PARAMS% shadowJar
			set DEPLOY_PROFILE=%ARGNEXT%
		set /a ARGI = !ARGI! + 1
		goto loopstart
	) else (
	  	if /I "%ARG%"=="-b" (
				set GRADLE_PARAMS=%GRADLE_PARAMS% shadowJar
				set DEPLOY_PROFILE=%ARGNEXT%
      	set /a ARGI = !ARGI! + 1
      	goto loopstart 
     ) else (		 
	if /I "%ARG%"=="--debug" (
	  set GRADLE_PARAMS=%GRADLE_PARAMS% --debug
	  set DEPLOY_PROFILE=%ARGNEXT%
		set /a ARGI = !ARGI! + 1
		goto loopstart
	) else (
	  	if /I "%ARG%"=="-x" (
	  	  set GRADLE_PARAMS=%GRADLE_PARAMS% 
	  	  set DEPLOY_PROFILE=%ARGNEXT% 
      	set /a ARGI = !ARGI! + 1
      	goto loopstart
    ) else (
		set GRADLE_PARAMS=%GRADLE_PARAMS%  rem %ARG%
		shift
		goto loopstart
    )
  )
  ))
  )
  )
  )
  )
  )
  )
:loopend

:execmd

call %APSARS_SDK_HOME%/bin/common.bat

%APSARS_SDK_HOME%\gradlew %GRADLE_PARAMS% -x test

exit /b 0

:showhelp
  echo.
  echo gradle Apsaras Software Development kit version 1.0.0
  echo.
  echo Usage: %0 [options]
  echo.
  echo -c [value], --compile local local nexus Server default:http://127.0.0.1:8081/neus
  echo -i [value], --install local local nexus Server default:http://127.0.0.1:8081/neus
  echo -x [value], --debug
  echo.
goto end

:parse_argv
  SET PARSE_ARGV_ARG=[]
  SET PARSE_ARGV_END=FALSE
  SET PARSE_ARGV_INSIDE_QUOTES=FALSE
  SET /A ARGC = 0
  SET /A PARSE_ARGV_INDEX=1
  
:PARSE_ARGV_LOOP
  CALL :PARSE_ARGV_CHAR !PARSE_ARGV_INDEX! "%%ARGV:~!PARSE_ARGV_INDEX!,1%%"
  IF ERRORLEVEL 1 (
    EXIT /B 1
  )
  IF !PARSE_ARGV_END! == TRUE (
    EXIT /B 0
  )
  SET /A PARSE_ARGV_INDEX=!PARSE_ARGV_INDEX! + 1
  GOTO :PARSE_ARGV_LOOP
 
  :PARSE_ARGV_CHAR
    IF ^%~2 == ^" (
      SET PARSE_ARGV_END=FALSE
      SET PARSE_ARGV_ARG=.%PARSE_ARGV_ARG:~1,-1%%~2.
      IF !PARSE_ARGV_INSIDE_QUOTES! == TRUE (
        SET PARSE_ARGV_INSIDE_QUOTES=FALSE
      ) ELSE (
        SET PARSE_ARGV_INSIDE_QUOTES=TRUE
      )
      EXIT /B 0
    )
    IF %2 == "" (
      IF !PARSE_ARGV_INSIDE_QUOTES! == TRUE (
        EXIT /B 1
      )
      SET PARSE_ARGV_END=TRUE
    ) ELSE IF NOT "%~2!PARSE_ARGV_INSIDE_QUOTES!" == " FALSE" (
      SET PARSE_ARGV_ARG=[%PARSE_ARGV_ARG:~1,-1%%~2]
      EXIT /B 0
    )
    IF NOT !PARSE_ARGV_INDEX! == 1 (
      SET /A ARGC = !ARGC! + 1
      SET ARG!ARGC!=%PARSE_ARGV_ARG:~1,-1%
      IF ^%PARSE_ARGV_ARG:~1,1% == ^" (
        SET ARG!ARGC!_=%PARSE_ARGV_ARG:~2,-2%
        SET ARG!ARGC!Q=%PARSE_ARGV_ARG:~1,-1%
      ) ELSE (
        SET ARG!ARGC!_=%PARSE_ARGV_ARG:~1,-1%
        SET ARG!ARGC!Q="%PARSE_ARGV_ARG:~1,-1%"
      )
      SET PARSE_ARGV_ARG=[]
      SET PARSE_ARGV_INSIDE_QUOTES=FALSE
    )
    EXIT /B 0

:getarg
  SET %2=!ARG%1!
  SET %2_=!ARG%1_!
  SET %2Q=!ARG%1Q!
  EXIT /B 0

:getargs
  SET %3=
  FOR /L %%I IN (%1,1,%2) DO (
    IF %%I == %1 (
      SET %3=!ARG%%I!
    ) ELSE (
      SET %3=!%3! !ARG%%I!
    )
  )
  EXIT /B 0
  
:end