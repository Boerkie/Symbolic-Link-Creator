@echo off
SET destination=C:\SymbolicLinks
REM Full path of the folder dragged and dropped as input
SET fullOriginalPath="%~1"

GOTO START_UP

:START_UP
	ECHO Starting symbolic link creator.
	ECHO %fullOriginalPath%
	PAUSE
	for /f "delims==" %%F in (%fullOriginalPath%) do set foldername=%%~nF
	ECHO Moving folder is: "%foldername%"
	PAUSE
	ECHO If this script fails for some reason, you can copy they files manualy as explained in the readme and run the following command:
	PAUSE
	ECHO MKLINK /J %fullOriginalPath% "%destination%\%foldername%"
	GOTO PREPARE_DESTINATION
	
:PREPARE_DESTINATION
	PAUSE
	IF EXIST "%destination%\%foldername%" (
		ECHO "%destination%\%foldername%" exists.
		GOTO COPY_FOLDER
	) ELSE (
		ECHO %destination%\%foldername% does not exists! Creating it now.
		MKDIR "%destination%\%foldername%"
		GOTO PREPARE_DESTINATION
	)

:COPY_FOLDER
	PAUSE
	ECHO Destination folder is: %destination%\%foldername%
	ECHO Copy command: %fullOriginalPath% "%destination%\%foldername%" /E /I /H /K
	XCOPY %fullOriginalPath% "%destination%\%foldername%" /E /I /H /K
	GOTO RENAME_OF_ORIGINAL

:RENAME_OF_ORIGINAL
	PAUSE
	ECHO Original input is: %fullOriginalPath%
	ECHO Original name is: %foldername%
	ECHO %fullOriginalPath% will be renamed to "%foldername% (Original)"
	REN %fullOriginalPath% "%foldername% (Original)"
	ECHO Folder is now at: "%foldername% (Original)"
	GOTO SYMBOLIC_LINK_CREATION

:SYMBOLIC_LINK_CREATION
	PAUSE
	ECHO Creating symbolic link %foldername% from %fullOriginalPath% now...
	ECHO MKLINK /J %fullOriginalPath% %destination%\%foldername%
	MKLINK /J %fullOriginalPath% "%destination%\%foldername%"
	ECHO Link created.
	GOTO SHUT_DOWN

:SHUT_DOWN
	ECHO Done.
	PAUSE
	EXIT
