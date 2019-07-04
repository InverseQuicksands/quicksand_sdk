@rem 上传项目jar包至maven仓库
%QUICKSAND_SDK_HOME%/gradlew.bat clean build uploadArchives -x test -x bootJar
