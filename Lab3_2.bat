@echo off

if [%1]==[/?] (
    echo Usage: filecount.bat [directory1] [directory2] ... [directoryN]
    echo Counts the number of files in the specified directories.
    echo Supports the following options:
    echo   /h - Counts hidden files
    echo   /r - Counts read-only files
    echo   /a - Counts archive files
    goto :eof
)
if "%1"=="" (
    echo Error: no directory specified.
    exit /b 1
)
setlocal EnableDelayedExpansion
set /a fileCount=0
set /a hiddenCount=0
set /a readOnlyCount=0
set /a archiveCount=0

for %%I in (%*) do (
    set /a dirFileCount=0
    set /a dirHiddenCount=0
    set /a dirReadOnlyCount=0
    set /a dirArchiveCount=0
    for /f "tokens=*" %%J in ('dir /a-d /b "%%~I"') do (
        set /a dirFileCount+=1
        attrib "%%~I\%%J" | find "H" > nul && set /a dirHiddenCount+=1
        attrib "%%~I\%%J" | find "R" > nul && set /a dirReadOnlyCount+=1
        attrib "%%~I\%%J" | find "A" > nul && set /a dirArchiveCount+=1
    )
    set /a fileCount+=dirFileCount
    set /a hiddenCount+=dirHiddenCount
    set /a readOnlyCount+=dirReadOnlyCount
    set /a archiveCount+=dirArchiveCount
    echo %%~I: Files: !dirFileCount! Hidden: !dirHiddenCount! Read-Only: !dirReadOnlyCount! Archive: !dirArchiveCount!
)
echo Total: Files: %fileCount% Hidden: %hiddenCount% Read-Only: %readOnlyCount% Archive: %archiveCount%
