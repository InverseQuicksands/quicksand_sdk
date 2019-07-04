@echo off

if "%DEPLOY_PROFILE%"=="" ( 
    set DEPLOY_PROFILE=local
) else ( 
    set DEPLOY_PROFILE=!DEPLOY_PROFILE!
)

if "%GRADLE_USER_HOME%"=="" (
    set GRADLE_USER_HOME=%QUICKSAND_SDK_HOME%/../repos
) else (
    set GRADLE_USER_HOME=%GRADLE_USER_HOME%
)

set GRADLE_OPTS=-Dfile.encoding=UTF-8 -Dprofile=%DEPLOY_PROFILE%
set buildGradleVersion=1.6.0
set REPOSITORY_LIB=http://maven.kawenet.com/nexus/content/groups/public