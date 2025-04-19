@echo off
setlocal


:: 1st Menu function
:Main_Menu
cls
echo ============================
echo         MAIN MENU
echo ============================
echo.
echo Would you like to Save (Backup) or Load your browser cache? 
echo.
echo 1. SAVE
echo 2. LOAD
echo ============================
set /p choice=Enter your choice (Just the number): 

if "%choice%"=="1" goto Save_Menu
if "%choice%"=="2" goto Load_Menu
if "%choice%"=="q" goto done
if "%choice%"=="Q" goto done

:: Invalid choice
echo Invalid selection. Please enter a valid option (just the number)
timeout /t 2 >nul
goto Main_Menu

:: Save Menu function
:Save_Menu
cls
echo ============================
echo        SAVE MENU
echo ============================
echo.
echo Which browser cache would you like to make a seperate copy of? 
echo.
echo 1. Save (Backup) Firefox Cache
echo 2. Save (Backup) Google Chrome Cache
echo 9. Return to Main Menu
echo ============================
set /p choice=Enter your choice (Just the number): 

if "%choice%"=="1" goto FirefoxSave_Progress
if "%choice%"=="2" goto Chrome_Save
if "%choice%"=="9" goto Main_Menu
if "%choice%"=="q" goto done
if "%choice%"=="Q" goto done

:: Invalid choice
echo Invalid selection. Please enter a valid option (just the number)
timeout /t 2 >nul
goto Main_Menu

:: Load Menu function
:Load_Menu
cls
echo ============================
echo         LOAD MENU
echo ============================
echo.
echo Which browser cache would you like to load? 
echo.
echo 1. Load Firefox Cache
echo 2. Load Google Chrome Cache
echo 9. Return to Main Menu
echo ============================
set /p choice=Enter your choice (Just the number): 

if "%choice%"=="1" goto Firefox_Load
if "%choice%"=="2" goto Chrome_Load
if "%choice%"=="9" goto Main_Menu
if "%choice%"=="q" goto done
if "%choice%"=="Q" goto done

:: Invalid choice
echo Invalid selection. Please enter a valid option (just the number)
timeout /t 2 >nul
goto Main_Menu

:Browser_Selection
::Here we want to use variables so we can reuse our save and load code without having to copy and paste code and take up extra space
:: We don't do this with Firefox since its cache is split in two, for who the hell knows why
:: Someday, we should further simplify this with an IF THEN statement

:Chrome_Save
:: Define CacheLocation and CacheBackup folders
set "CacheLocation=%localappdata%\Google\Chrome\User Data"
set "CacheBackup=%~dp0ChromeSave"
set "Complete_name=Google Chrome Cache Save"
goto Save
:Chrome_Load
:: Define CacheLocation and CacheBackup folders
set "CacheLocation=%localappdata%\Google\Chrome\User Data"
set "CacheBackup=%~dp0ChromeSave"
set "Complete_name=Google Chrome Cache Load"
goto Load



::--------- 
::---------Save------------------------------------------------------------------------------------------------------------------------------------------------ 
::--------- 
:Save

:: Create CacheBackup folder if it doesn't exist
if not exist "%CacheBackup%" mkdir "%CacheBackup%"

:: Start XCOPY in a separate process
echo Copying files...
start /b xcopy "%CacheLocation%" "%CacheBackup%" /E /I /H /Y >nul 2>&1

:: Initialize loading bar
set "bar="
set /A count=0

:: Display loading animation while XCOPY runs

:Save_Progress
:: Check if XCOPY is still running
tasklist | find /i "xcopy.exe" >nul
if %errorlevel% neq 0 goto done

:: Update loading bar
set /A count+=1
if %count%==1 set "bar=[>         ]"
if %count%==2 set "bar=[=>        ]"
if %count%==3 set "bar=[==>       ]"
if %count%==4 set "bar=[===>      ]"
if %count%==5 set "bar=[====>     ]"
if %count%==6 set "bar=[=====>    ]"
if %count%==7 set "bar=[======>   ]"
if %count%==8 set "bar=[=======>  ]"
if %count%==9 set "bar=[========> ]"
if %count%==10 set "bar=[=========>]"
if %count%==11 set "bar=[=>         ]" & set /A count=0

:: Print loading bar and refresh
<nul set /p "=Copying files... %bar%" 
timeout /t 1 >nul
echo.

goto Save_Progress

::--------- 
::---------Firefox Save------------------------------------------------------------------------------------------------------------------------------------------------ 
::--------- 

:FirefoxSave_Progress
:: Define FFsource1 and FFdestination1 folders
set "FFsource1=%localappdata%\Mozilla\Firefox\Profiles"
set "FFdestination1=%~dp0"FFSave\L
set "name=Firefox Local Cache Save"

:: Create FFdestination1 folder if it doesn't exist
if not exist "%FFdestination1%" mkdir "%FFdestination1%"

:: Start XCOPY in a separate process
echo Copying files...
start /b xcopy "%FFsource1%" "%FFdestination1%" /E /I /H /Y >nul 2>&1

:: Initialize loading bar
set "bar="
set /A count=0

:: Display loading animation while XCOPY runs

:FF_Progress1
:: Check if XCOPY is still running
tasklist | find /i "xcopy.exe" >nul
if %errorlevel% neq 0 goto FirefoxSave_Done.5

:: Update loading bar
set /A count+=1
if %count%==1 set "bar=[>         ]"
if %count%==2 set "bar=[=>        ]"
if %count%==3 set "bar=[==>       ]"
if %count%==4 set "bar=[===>      ]"
if %count%==5 set "bar=[====>     ]"
if %count%==6 set "bar=[=====>    ]"
if %count%==7 set "bar=[======>   ]"
if %count%==8 set "bar=[=======>  ]"
if %count%==9 set "bar=[========> ]"
if %count%==10 set "bar=[=========>]"
if %count%==11 set "bar=[=>         ]" & set /A count=0

:: Print loading bar and refresh
<nul set /p "=Copying files... %bar%" 
timeout /t 1 >nul
echo.

goto FF_Progress1

:FirefoxSave_Done.5
echo %name% complete!
goto FirefoxSave_Progress2

:FirefoxSave_Progress2
:: Define FFsource2 and FFdestination2 folders
set "FFsource2=%appdata%\Mozilla\Firefox\Profiles"
set "FFdestination2=%~dp0"FFSave\R
set "Complete_name=Firefox Roaming Cache Save"

:: Create FFdestination2 folder if it doesn't exist
if not exist "%FFdestination2%" mkdir "%FFdestination2%"

:: Start XCOPY in a separate process
echo Copying files...
start /b xcopy "%FFsource2%" "%FFdestination2%" /E /I /H /Y >nul 2>&1

:: Initialize loading bar
set "bar="
set /A count=0

:: Display loading animation while XCOPY runs

:FF_Progress2
:: Check if XCOPY is still running
tasklist | find /i "xcopy.exe" >nul
if %errorlevel% neq 0 goto done

:: Update loading bar
set /A count+=1
if %count%==1 set "bar=[>         ]"
if %count%==2 set "bar=[=>        ]"
if %count%==3 set "bar=[==>       ]"
if %count%==4 set "bar=[===>      ]"
if %count%==5 set "bar=[====>     ]"
if %count%==6 set "bar=[=====>    ]"
if %count%==7 set "bar=[======>   ]"
if %count%==8 set "bar=[=======>  ]"
if %count%==9 set "bar=[========> ]"
if %count%==10 set "bar=[=========>]"
if %count%==11 set "bar=[=>         ]" & set /A count=0

:: Print loading bar and refresh
<nul set /p "=Copying files... %bar%" 
timeout /t 1 >nul
echo.

goto FF_Progress2

::--------- 
::---------Load------------------------------------------------------------------------------------------------------------------------------------------------ 
::--------- 
:Load

::if exist "%~dp0%CacheBackup%" (
    echo Cache located.
	
:: Start XCOPY in a separate process
echo Overwriting files...
start /b xcopy "%CacheBackup%" "%CacheLocation%"  /E /I /H /Y >nul 2>&1

:: Initialize loading bar
set "bar="
set /A count=0

:: Display loading animation while XCOPY runs

:Load_Progress
:: Check if XCOPY is still running
tasklist | find /i "xcopy.exe" >nul
if %errorlevel% neq 0 goto done

:: Update loading bar
set /A count+=1
if %count%==1 set "bar=[>         ]"
if %count%==2 set "bar=[=>        ]"
if %count%==3 set "bar=[==>       ]"
if %count%==4 set "bar=[===>      ]"
if %count%==5 set "bar=[====>     ]"
if %count%==6 set "bar=[=====>    ]"
if %count%==7 set "bar=[======>   ]"
if %count%==8 set "bar=[=======>  ]"
if %count%==9 set "bar=[========> ]"
if %count%==10 set "bar=[=========>]"
if %count%==11 set "bar=[=>         ]" & set /A count=0

:: Print loading bar and refresh
<nul set /p "=Copying files... %bar%" 
timeout /t 1 >nul
echo.

goto Load_Progress
	
	
::) else (
    echo There is no cache folder. Did you mean to Save/Backup your cache? Returning you to the Main Menu.
::	goto Main_Menu
::)

::--------- 
::---------Firefox Load------------------------------------------------------------------------------------------------------------------------------------------------ 
::--------- 

:Firefox_Load1

:: Define FFsource1 and FFdestination1 folders
set "FFsource1=%localappdata%\Mozilla\Firefox\Profiles"
set "FFdestination1=%~dp0FFSave\L"
set "name=Firefox Local Cache Save"

::if exist "%FFdestination1%" (
    echo Cache located.
	
:: Start XCOPY in a separate process
echo Overwriting files...
start /b xcopy "%FFdestination1%" "%FFsource1%"  /E /I /H /Y >nul 2>&1

:: Initialize loading bar
set "bar="
set /A count=0

:: Display loading animation while XCOPY runs

:FirefoxLoad_Progress1
:: Check if XCOPY is still running
tasklist | find /i "xcopy.exe" >nul
if %errorlevel% neq 0 goto Firefox_LoadDone.5

:: Update loading bar
set /A count+=1
if %count%==1 set "bar=[>         ]"
if %count%==2 set "bar=[=>        ]"
if %count%==3 set "bar=[==>       ]"
if %count%==4 set "bar=[===>      ]"
if %count%==5 set "bar=[====>     ]"
if %count%==6 set "bar=[=====>    ]"
if %count%==7 set "bar=[======>   ]"
if %count%==8 set "bar=[=======>  ]"
if %count%==9 set "bar=[========> ]"
if %count%==10 set "bar=[=========>]"
if %count%==11 set "bar=[=>         ]" & set /A count=0

:: Print loading bar and refresh
<nul set /p "=Copying files... %bar%" 
timeout /t 1 >nul
echo.

goto FirefoxLoad_Progress1

::) else (
    echo There is no cache folder. Did you mean to Save/Backup your cache? Returning you to the Main Menu.
::	goto Main_Menu
::)


:Firefox_LoadDone.5
echo %name% complete!
goto Firefox_Load2

:Firefox_Load2
:: Define FFsource1 and FFdestination1 folders
set "FFsource2=%appdata%\Mozilla\Firefox\Profiles"
set "FFdestination2=%~dp0FFSave\R"
set "name=Firefox Roaming Cache Save"

::if exist "%FFdestination2%" (
    echo Cache located.
	
:: Start XCOPY in a separate process
echo Overwriting files...
start /b xcopy "%FFdestination2%" "%FFsource2%"  /E /I /H /Y >nul 2>&1

:: Initialize loading bar
set "bar="
set /A count=0

:: Display loading animation while XCOPY runs

:FirefoxLoad_Progress2
:: Check if XCOPY is still running
tasklist | find /i "xcopy.exe" >nul
if %errorlevel% neq 0 goto done

:: Update loading bar
set /A count+=1
if %count%==1 set "bar=[>         ]"
if %count%==2 set "bar=[=>        ]"
if %count%==3 set "bar=[==>       ]"
if %count%==4 set "bar=[===>      ]"
if %count%==5 set "bar=[====>     ]"
if %count%==6 set "bar=[=====>    ]"
if %count%==7 set "bar=[======>   ]"
if %count%==8 set "bar=[=======>  ]"
if %count%==9 set "bar=[========> ]"
if %count%==10 set "bar=[=========>]"
if %count%==11 set "bar=[=>         ]" & set /A count=0

:: Print loading bar and refresh
<nul set /p "=Copying files... %bar%" 
timeout /t 1 >nul
echo.

goto FirefoxLoad_Progress2

::) else (
    echo There is no cache folder. Did you mean to Save/Backup your cache? Returning you to the Main Menu.
::	goto Main_Menu
::)
	
	




::---------
::---------EOF-----------------------------------------------------------
::---------

:done
echo.
echo %Complete_name% complete!
pause
