# Symbolic-Link-Creator
Batch file to create symbolic links. Useful for solid state drive management.

## What is a Symbolic Link?
A symbolic link, also termed a soft link, is a special kind of file that points to another file, much like a shortcut in Windows or a Macintosh alias. Unlike a hard link, a symbolic link does not contain the data in the target file. It simply points to another entry somewhere in the file system.

## Why use it?
So you just got a solid state drive and want to only add the special programs to it? An easy way to do that is to create a Symbolic Link from the program's original location, to its new location on your solid state, without any dependant software even realising the location is different.

## How to use version 2?
Simply drag and drop the folder you want on the your solid state on the batch file and it will do the rest.

## How to use version 1?
Paste the Symbolic-Link-Creator.bat file in any location listed in your path environment variable. I recommend renameing it to slc.bat.

Click 'Start'
Type 'cmd'
Type 'path'
Select any directory listed in the path. For example 'C:\WINDOWS\system32'
Copy the slc.bat file to the selected location.
	
Now you can open a command prompt window anywhere and just type 'slc <optional argument>'.

For example, when you are in the parent folder of the folder you want to move, just type 'cmd' in the address bar.
Then type 'slc %cd%\folderNameToLink', which will automaticaly kick off the slc.bat script with the folder you want to create the link for.

For instance. I am in 'C:\Program Files (x86)\Origin Games' and I want to move my 'Battlefield 4' folder.
Type cmd in the address bar.
Console will open on: C:\Program Files (x86)\Origin Games>

Enter: slc %cd%"\Battlefield 4"
Since there is a space in the name.
And Wola!

## How to create a link without this batch file?
If it is not working for some reason, there are essentially 3 things can do that will provide the same results.
1. __Copy the original progam's folder__ to a desired location on the solid state. I suggest to use "C:\SymbolicLinks", as this provides a central location for all the programs you created symbolic links for.
2. __Rename or remove the orignial folder.__ The link cannot be created if a folder with the same name already exists in the destination folder. For ease of reverting, I recommend renaming the folder by appending "(Original)" at the end. E.g. "FolderName (Original)". When you don't want to make use of the link anymore. Simply delete the shortcut (created in the next step) and rename it back to its original name.
3. __Run the below command.__ Where __%originalLocation%__ is the full path for folder you want to create the link for (E.g. "D:\Program Files\Internet Explorer") and __%destinatioFoldername%__ the location of where you want the files to live on your solid state (E.g. "C:\SymbolicLinks\Internet Explorer").

__MKLINK /J %input% %destinatioFoldername%__

## Notes
Remember to wrap path names in double quotes if it contains spaces. (For version 1)
You can't be in the folder you want to create the link for if it is not renamed already.
The folder name cannot contain special characters.

## Practical example
You want to move Overwatch, PUBG and Battelfield 4 to your solid state drive so that they load/run faster. But you don't want any of the digital distribution platforms (Battle.net, Steam, Origin) knowing that they are now in a different location. If you follow the convention of your solid state being your C drive, and a bigger slower hard drive being your D drive, it could be as simple as this

### For version 2:
1. Download and save copy of Symbolic-Link-Creator v2.bat.
2. Drag your Overwatch install directory (e.g. "D:\Program Files (x86)\Overwatch") on to the Symbolic-Link-Creator v2.bat file.
3. Wait for it to say "Done".
4. Drag your PUBG install directory (e.g. "D:\Program Files (x86)\Steam\SteamApps\common\PUBG") on to the Symbolic-Link-Creator v2.bat file.
5. Wait for it to say "Done".
4. Drag your Battlefield 4 install directory (e.g. "D:\Program Files (x86)\Origin Games\Battlefield 4") on to the Symbolic-Link-Creator v2.bat file.
5. Wait for it to say "Done".
6. In "C:\SymbolicLinks", you will now find a folder for Overwatch, PUBG and Battlefield 4 with none of the digital distribution platforms any wiser.
