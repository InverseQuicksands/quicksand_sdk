@echo off

@rem create project

%QUICKSAND_SDK_HOME%/gradlew.bat init --type basic --dsl groovy --project-name=%1