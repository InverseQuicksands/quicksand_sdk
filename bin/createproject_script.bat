@echo off

@rem create project

%QUICKSAND_SDK_HOME%/bin/gradlew.bat init --type basic --dsl groovy --project-name=%1