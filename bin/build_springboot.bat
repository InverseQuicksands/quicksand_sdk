@rem 编译springboot项目打包命令

@rem From Spring Boot release 2.0 M1 the bootRepackage task has been replaced with bootJar and bootWar tasks
@rem %QUICKSAND_SDK_HOME%/gradlew.bat clean build -x test -x bootRepackage
@gradlew.bat clean build -x test -x bootJar