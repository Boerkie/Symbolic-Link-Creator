@echo off
SET destination=C:\SymbolicLinks

ECHO Starting symbolic link creator

FOR %%A IN (%*) DO (
    ECHO %%A
	IF "%%A"=="" (
		GOTO noArg
	) ELSE (
		SET pram=%%A
		GOTO withArg
	)
)
goto help

:withArg
	ECHO %pram%
	SET input=%pram%
	ECHO Input argument is :%input%
	GOTO testExistence

:noArg
	ECHO Enter the folder that you want to create a symbolic link for:
	ECHO [For example: D:\Program Files (x86)\folderXY]
	SET /P input=
	ECHO You typed: "%input%"
	GOTO testExistence

:testExistence
	ECHO Testing to see if %input% exist.
	IF EXIST %input% (
		ECHO The souce location %input% exists.
		GOTO getNewFolder
	) else (
		ECHO The folder "%input%" does not exist.
		GOTO noArgs
	)

:getNewFolder
	FOR /f "delims==" %%F in ("%input%") do set foldername=%%~nF
	ECHO Moving folder is: %foldername%
	GOTO copyFolder

:copyFolder
	ECHO Destination folder is: %destination%\%foldername%
	IF EXIST %destination%\%foldername% (
		ECHO %destination%\%foldername% exists.
		ECHO Copying...
		XCOPY %input% %destination%\%foldername% /E /I /H /K
		ECHO Copied.
		GOTO checkCopy
	) ELSE (
		ECHO %destination%\%foldername% does not exists! Creating it now.
		MKDIR %destination%\%foldername%
		GOTO copyFolder
	)

:checkCopy
	ECHO Checking the see if the copy was successful...
	FOR /F %%i in ('dir /b "%destination%\%foldername%*.*"') do (
		
		SET emptyCheck=1
		GOTO errorCheck
	)

:errorCheck
	IF %emptyCheck%==1 (
		ECHO It looks like the copy worked. Phwew...
		GOTO rename
	) ELSE (
		ECHO Seems like the copy failed, go check the folder to see if it is there.
		ECHO If it is then this was a false possitive, to finish the proccess, rename or delete the original folder (since the copy did pass)
		ECHO Once that is done run the following command: MKLINK /J "%input%" "%destination%\%foldername%"
		GOTO end
	)

:rename
	ECHO Copy is done, will now have to rename the original file, since the symbolic link will appear the be the original folder.
	ECHO Original input is: %input%
	ECHO Original name is: %foldername%
	ECHO %input% "%foldername% (Original)"
	REN %input% "%foldername% (Original)"
	ECHO Folder is now at: "%input% (Original)"
	
:creatLink
	ECHO Creating symbolic link %input% from %destination%\%foldername% now...
	MKLINK /J %input% %destination%\%foldername%
	ECHO Link created.
	GOTO Done

:help
	ECHO This batch file can be ran with or without paramaters. It only expects one paramater and that is the folder you want to create a symbolic link for.
	ECHO It will copy the folder and all of its contents to the SymbolicLinks folder at C:\SymbolicLinks so that its new location will be C:\SymbolicLinks\folderXY.
	ECHO Then it will delete or rename the original folder after a successful copy. The rename will append " (Original)" after the name. E.g. "folderXY (Original)"
	ECHO The rename must be done before the SymbolicLink is created, since the link will make it look asif the folder is still there.
	ECHO Finally the link will be created.
	ECHO After the link is created "C:\SymbolicLinks\folderXY" will exist and "D:\Program Files (x86)\folderXY]" will be a link to it. Thus programs using "D:\Program Files (x86)\folderXY]" will load from "C:\SymbolicLinks\folderXY"	
	ECHO.
	GOTO noArgs

:end
	ECHO Something whent wrong, look at the line above this for the error.
	GOTO done

:done
	ECHO Done.
	pause
	exit
