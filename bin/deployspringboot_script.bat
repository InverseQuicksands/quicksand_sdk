@echo off

@rem �ϴ���Ŀjar����maven�ֿ�
call %QUICKSAND_SDK_HOME%/bin/common.bat
%QUICKSAND_SDK_HOME%/bin/gradlew.bat clean build uploadArchives -x test -x bootJar
