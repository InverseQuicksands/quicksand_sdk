@echo off

@rem 上传项目jar包至maven仓库
call %QUICKSAND_SDK_HOME%/bin/common.bat
%QUICKSAND_SDK_HOME%/gradlew.bat clean build uploadArchives -x test -x bootJar
