@echo off
cls
title Gradle 项目创建工具
color 0A
echo.
echo        ===========================================================
echo.
echo                            Gradle 项目创建工具
echo.
echo        ===========================================================
echo        请选择下面的数字：
echo.
echo        1：创建工程
echo.
echo        2：编译项目
echo.
echo        3：打包项目
echo.
echo        4：上传maven库
echo.
echo        5：help
echo.
echo        Q：退出
echo.

@rem 如果是Windows系统，则开启命令扩展和命令延迟
if "%OS%" == "Windows_NT" setlocal enableextensions enabledelayedexpansion

@rem 计算去空格后输入字符的长度
set len=0

:cho
set /p choice=请选择：
IF NOT "%choice%"=="" (
    SET choice=%choice:~0,1%
    set var=%choice: =%
    call :varlen !var!
    @rem 判断输入的字符长度是否大于等于2
    if !len! geq 2 (
        echo 选择无效，请重新输入......
        echo. 
        goto cho
    )

    @rem 如果输入的字符是1    
    if /i "%choice%"=="1" (
        goto createproject
        
    )

    @rem 如果输入的字符是2 
    if /i "%choice%"=="2" (
        goto compileproject
    )

    @rem 如果输入的字符是3
    if /i "%choice%"=="3" (
        goto buildproject

    )

    @rem 如果输入的字符是4
    if /i "%choice%"=="4" (
        goto publishproject
    )
    
    @rem 如果输入的字符是5
    if /i "%choice%"=="5" (
        goto help
    )

    @rem 如果输入的字符是help
    if /i "%choice%"=="help" (
        goto help
    )

    @rem 如果输入的字符是Q/q
    if /i "%choice%"=="Q" (
        goto end
    )
) else (
    echo 选择无效，请重新输入......
    echo. 
    goto cho
)

@rem ============================================= 针对输入进行校验 ==========================================
@rem 计算输入字符长度
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


@rem ============================================ 创建项目 ===================================================
@rem 创建项目的方法,项目名称不能为空，模块名可以为空
:createproject
    set /p projectpath=请输入项目创建目录[默认当前目录]：
    set /p projectname=请输入项目名称：
    set /p moudlename=请输入模块名称(以逗号分隔)：

    if "%projectpath%" == "" (
        set proname="!projectname!"
        if !proname! == "" (
            echo 温馨提示：项目名称不能为空，请重新选择......
            goto cho
        ) else (
            set proname=!proname: =!
            if !proname! == "" (
                echo 温馨提示：项目名称不能为空，请重新选择......
                goto cho
            ) else (
                @rem 进入指定目录创建文件夹
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
            echo 温馨提示：项目名称不能为空，请重新选择......
            goto cho
        ) else (
            set proname=!proname: =!
            if !proname! == "" (
                echo 温馨提示：项目名称不能为空，请重新选择......
                goto cho
            ) else (
                @rem 进入指定目录创建文件夹
                call :createprojectfolder "%projectpath%" !proname!
                if defined propath (
                    call :cremod
                    pause >nul
                )
            )  
        )
    )
exit /B 0


@rem 创建模块的方法
:cremod
    set remain=%moudlename%
    if "%moudlename%" == "" (
        echo 温馨提示：模块名为空，将创建基项目......
        exit /B 0
    ) else (
        set remain=!remain: =!
        if "!remain!" == "" (
            echo 温馨提示：模块名为空，将创建基项目......
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


@rem 创建项目名称目录
:createprojectfolder
    cd /d %1
    md %2 & cd /d %2
    set propath=%cd%
    @rem 构建gradle，执行gradle init
    call create_project.bat %projectname%
goto :eof


@rem 创建模块目录
:createmoudlefolder
    cd /d %1
    if not exist %2 (
    md %2\src\main\java & md %2\src\main\resources & md %2\src\test\java & md %2\src\test\resources
    ) else (
        echo 该模块已存在......
        exit /B 1
    ) 
goto :eof
@rem ============================================= End ======================================================


@rem ============================================= 编译项目 ==================================================
@rem 编译项目的方法
:compileproject
    echo 温馨提示：编译项目可直接使用complileproject_script.bat脚本，亦可使用此脚本
    set /p folderpath=请输入项目位置：
    if "%folderpath%" == "" (
        echo 项目位置不可为空，请重新输入！
        goto compileproject
    ) else (
        set foldpath="%folderpath%"
        cd /d "!foldpath!"
        call complileproject_script.bat
        pause >nul
    )
exit /B 0
@rem ============================================= End =======================================================


@rem ============================================= 打包项目方法 ===============================================
@rem 打包项目的方法
:buildproject
    echo 温馨提示：打包项目可直接使用buildspringboot_script.bat脚本，亦可使用此脚本
    set /p builderpath=请输入项目位置：
    if "%builderpath%" == "" (
        echo 项目位置不可为空，请重新输入！
        goto buildproject
    ) else (
        set buildpath="%builderpath%"
        cd /d "!buildpath!"
        call buildspringboot_script.bat
        pause >nul
    )
exit /B 0
@rem ============================================= End =======================================================


@rem ============================================= 上传maven库 ================================================
@rem 上传maven库的方法
:publishproject
    echo 温馨提示：打包项目可直接使用deployspringboot_script.bat脚本，亦可使用此脚本
    set /p deployerpath=请输入项目位置：
    if "%deployerpath%" == "" (
        echo 项目位置不可为空，请重新输入！
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
@rem 帮助
:help
    echo 此脚本是为了方便创建工程，用于日常开发时编译项目、打包使用，适用于gradle构建项目时使用
    echo 通过选择数字，进行对应的操作
    goto cho
exit /B 0


@rem 退出
:end
endlocal
exit /B 0
@rem ============================================= End =======================================================
