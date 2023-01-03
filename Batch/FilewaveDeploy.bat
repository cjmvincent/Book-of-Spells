@echo off

SET MCS_ENDPOINT=Filewave\FileWaveClientAssistant.exe
IF "%PROCESSOR_ARCHITECTURE%" == "x86" GOTO X86_PROG
IF NOT EXIST "%ProgramFiles(x86)%\%MCS_ENDPOINT%" GOTO INSTALL
exit /b 0

:X86_PROG
IF NOT EXIST "%ProgramFiles%\%MCS_ENDPOINT%" GOTO INSTALL
exit /b 0

:INSTALL
pushd \\bcboe-wsus\Distrib\All\Filewave
FileWaveClient_13.0.1-NoBooster.msi 
Popd