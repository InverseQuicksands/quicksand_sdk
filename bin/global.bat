@echo off
cls
title Gradle ��Ŀ��������
color 0A
echo.
echo        ===========================================================
echo.
echo                            Gradle ��Ŀ��������
echo.
echo        ===========================================================
echo        ��ѡ����������֣�
echo.
echo        1����������
echo.
echo        2��������Ŀ
echo.
echo        3�������Ŀ
echo.
echo        4���ϴ�maven��
echo.
echo        5��help
echo.
echo        Q���˳�
echo.

@rem �����Windowsϵͳ������������չ�������ӳ�
if "%OS%" == "Windows_NT" setlocal enableextensions enabledelayedexpansion

@rem ����ȥ�ո�������ַ��ĳ���
set len=0

:cho
set /p choice=��ѡ��
IF NOT "%choice%"=="" (
    SET choice=%choice:~0,1%
    set var=%choice: =%
    call :varlen !var!
    @rem �ж�������ַ������Ƿ���ڵ���2
    if !len! geq 2 (
        echo ѡ����Ч������������......
        echo. 
        goto cho
    )

    @rem ���������ַ���1    
    if /i "%choice%"=="1" (
        goto createproject
        
    )

    @rem ���������ַ���2 
    if /i "%choice%"=="2" (
        goto compileproject
    )

    @rem ���������ַ���3
    if /i "%choice%"=="3" (
        goto buildproject

    )

    @rem ���������ַ���4
    if /i "%choice%"=="4" (
        goto publishproject
    )
    
    @rem ���������ַ���5
    if /i "%choice%"=="5" (
        goto help
    )

    @rem ���������ַ���help
    if /i "%choice%"=="help" (
        goto help
    )

    @rem ���������ַ���Q/q
    if /i "%choice%"=="Q" (
        goto end
    )
) else (
    echo ѡ����Ч������������......
    echo. 
    goto cho
)

@rem ============================================= ����������У�� ==========================================
@rem ���������ַ�����
:varlen
    set str=%1
    if not defined str goto :eof
    set num=0
    :label
    set /a num+=1
    set str=%str:~0,-1%
    if defined str goto :label
    set len=%num%
EXIT /B 0
@rem ============================================== End =====================================================


@rem ============================================ ������Ŀ ===================================================
@rem ������Ŀ�ķ���,��Ŀ���Ʋ���Ϊ�գ�ģ��������Ϊ��
:createproject
    set /p projectpath=��������Ŀ����Ŀ¼[Ĭ�ϵ�ǰĿ¼]��
    set /p projectname=��������Ŀ���ƣ�
    set /p moudlename=������ģ������(�Զ��ŷָ�)��

    if "%projectpath%" == "" (
        set proname="!projectname!"
        if !proname! == "" (
            echo ��ܰ��ʾ����Ŀ���Ʋ���Ϊ�գ�������ѡ��......
            goto cho
        ) else (
            set proname=!proname: =!
            if !proname! == "" (
                echo ��ܰ��ʾ����Ŀ���Ʋ���Ϊ�գ�������ѡ��......
                goto cho
            ) else (
                @rem ����ָ��Ŀ¼�����ļ���
                call :createprojectfolder "!cd!" !proname!
                if defined propath (    
                    call :cremod
                    pause >nul
                )
            )
        )
        
    ) else (
        set proname="!projectname!"
        if !proname! == "" (
            echo ��ܰ��ʾ����Ŀ���Ʋ���Ϊ�գ�������ѡ��......
            goto cho
        ) else (
            set proname=!proname: =!
            if !proname! == "" (
                echo ��ܰ��ʾ����Ŀ���Ʋ���Ϊ�գ�������ѡ��......
                goto cho
            ) else (
                @rem ����ָ��Ŀ¼�����ļ���
                call :createprojectfolder "%projectpath%" !proname!
                if defined propath (
                    call :cremod
                    pause >nul
                )
            )  
        )
    )
exit /B 0


@rem ����ģ��ķ���
:cremod
    set remain=%moudlename%
    if "%moudlename%" == "" (
        echo ��ܰ��ʾ��ģ����Ϊ�գ�����������Ŀ......
        exit /B 0
    ) else (
        set remain=!remain: =!
        if "!remain!" == "" (
            echo ��ܰ��ʾ��ģ����Ϊ�գ�����������Ŀ......
            exit /B 0
        ) else (
            :loop
            for /f "tokens=1* delims=," %%a in ("!remain!") do (
                set moudle=%%a
                set moudle=!moudle: =!
                call :createmoudlefolder "!propath!" !moudle!
                set remain=%%b
            )
            if defined remain goto :loop
        )
    )
goto :eof


@rem ������Ŀ����Ŀ¼
:createprojectfolder
    cd /d %1
    md %2 & cd /d %2
    set propath=%cd%
    @rem ����gradle��ִ��gradle init
    call create_project.bat %projectname%
goto :eof


@rem ����ģ��Ŀ¼
:createmoudlefolder
    cd /d %1
    if not exist %2 (
    md %2\src\main\java & md %2\src\main\resources & md %2\src\test\java & md %2\src\test\resources
    ) else (
        echo ��ģ���Ѵ���......
        exit /B 1
    ) 
goto :eof
@rem ============================================= End ======================================================


@rem ============================================= ������Ŀ ==================================================
@rem ������Ŀ�ķ���
:compileproject
    echo ��ܰ��ʾ��������Ŀ��ֱ��ʹ��complileproject_script.bat�ű������ʹ�ô˽ű�
    set /p folderpath=��������Ŀλ�ã�
    if "%folderpath%" == "" (
        echo ��Ŀλ�ò���Ϊ�գ����������룡
        goto compileproject
    ) else (
        set foldpath="%folderpath%"
        cd /d "!foldpath!"
        call complileproject_script.bat
        pause >nul
    )
exit /B 0
@rem ============================================= End =======================================================


@rem ============================================= �����Ŀ���� ===============================================
@rem �����Ŀ�ķ���
:buildproject
    echo ��ܰ��ʾ�������Ŀ��ֱ��ʹ��buildspringboot_script.bat�ű������ʹ�ô˽ű�
    set /p builderpath=��������Ŀλ�ã�
    if "%builderpath%" == "" (
        echo ��Ŀλ�ò���Ϊ�գ����������룡
        goto buildproject
    ) else (
        set buildpath="%builderpath%"
        cd /d "!buildpath!"
        call buildspringboot_script.bat
        pause >nul
    )
exit /B 0
@rem ============================================= End =======================================================


@rem ============================================= �ϴ�maven�� ================================================
@rem �ϴ�maven��ķ���
:publishproject
    echo ��ܰ��ʾ�������Ŀ��ֱ��ʹ��deployspringboot_script.bat�ű������ʹ�ô˽ű�
    set /p deployerpath=��������Ŀλ�ã�
    if "%deployerpath%" == "" (
        echo ��Ŀλ�ò���Ϊ�գ����������룡
        goto buildproject
    ) else (
        set deploypath="%deployerpath%"
        cd /d "!deploypath!"
        call deployspringboot_script.bat
        pause >nul
    )
exit /B 0
@rem ============================================= End =======================================================


@rem ============================================= help ======================================================
@rem ����
:help
    echo �˽ű���Ϊ�˷��㴴�����̣������ճ�����ʱ������Ŀ�����ʹ�ã�������gradle������Ŀʱʹ��
    echo ͨ��ѡ�����֣����ж�Ӧ�Ĳ���
    goto cho
exit /B 0


@rem �˳�
:end
endlocal
exit /B 0
@rem ============================================= End =======================================================
