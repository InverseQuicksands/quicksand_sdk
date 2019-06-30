@echo off

if "%DEPLOY_PROFILE%"=="" ( 
	set DEPLOY_PROFILE=local
) else ( 
	set DEPLOY_PROFILE=!DEPLOY_PROFILE!
)


set GRADLE_USER_HOME=%APSARS_SDK_HOME%/../repos
set GRADLE_OPTS=-Dfile.encoding=UTF-8 -Dprofile=%DEPLOY_PROFILE%
set buildGradleVersion=1.6.0
set REPOSITORY_LIB=http://maven.kawenet.com/nexus/content/groups/public