@echo off
cd "C:\Лабараторні\Група\ФІП\batch"
mkdir "HidenFolder"
mkdir "NotHidenFolder"
attrib +h "HidenFolder"
xcopy /? > "NotHidenFolder\copyhelp.txt"
xcopy "NotHidenFolder\copyhelp.txt" "HidenFolder\copied_copyhelp.txt"