@echo off

@rem ����springboot��Ŀ�������
@rem From Spring Boot release 2.0 M1 the bootRepackage task has been replaced with bootJar and bootWar tasks
@rem %QUICKSAND_SDK_HOME%/gradlew.bat clean build -x test -x bootRepackage
@rem springboot 2.x�汾���war��������
@rem gradlew.bat clean build -x test -x bootWar

%QUICKSAND_SDK_HOME%/bin/gradlew.bat clean build -x test -x bootJar