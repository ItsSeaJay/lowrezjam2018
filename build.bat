@echo off

rem NOTE: This script assumes that 7-Zip is installed on the Windows system PATH

set name=lowrezjam2018

rem Make a build folder if one doesn't already exist
mkdir build

rem Clear the contents of the build folder
del build\%name%.zip
del build\%name%_windows.zip
del build\%name%.love
del build\%name%.exe

rem Compress the contents of the repo into a zipped folder
7z a -r build\%name%.zip
rem Create a copy of that zipped folder with the extension changed around
copy build\%name%.zip build\%name%.love
rem Append the contents of the love2d executable to the end of the archive
rem to create an executable file
copy /b D:\LOVE\love.exe+build\%name%.love build\%name%.exe
rem Add that executable along with any necessary resources to a final zip folder
7z a build\%name%_windows.zip -i!build\%name%.exe -i!bin\love.dll
