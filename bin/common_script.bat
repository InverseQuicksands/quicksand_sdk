@echo off

if "%GRADLE_USER_HOME%"=="" (
    set GRADLE_USER_HOME=%QUICKSAND_SDK_HOME%/../repos
) else (
    set GRADLE_USER_HOME=%GRADLE_USER_HOME%
)

set GRADLE_OPTS=-Dfile.encoding=UTF-8
@rem springboot 版本
set buildGradleVersion=2.1.0

set REPOSITORY_USER=admin
set REPOSITORY_PASSWORD=admin123
set REPOSITORY_LIB=http://xxx/repository/maven-releases/