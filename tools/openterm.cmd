@echo off

rem openvt - launch the vtterm binary
rem Runs the VtPipeTerm.exe binary generated by the build in the debug directory.
rem    Passes any args along.

setlocal
set _last_build_bin=%OPENCON%\bin\%ARCH%\%_LAST_BUILD_CONF%
set _last_build=%OPENCON%\%ARCH%\%_LAST_BUILD_CONF%
set _package_output=%OPENCON%\src\cascadia\CascadiaPackage\bin\%ARCH%\%_LAST_BUILD_CONF%

if not exist %_last_build%\WindowsTerminal.exe (
    echo Could not locate the WindowsTerminal.exe in %_last_build%. Double check that it has been built and try again.
    goto :eof
)

set _r=%random%
set copy_dir=OpenConsole\%_r%\WindowsTerminal
rem Generate a unique name, so that we can debug multiple revisions of the binary at the same time if needed.

(xcopy /Y %_last_build_bin%\OpenConsole.exe %TEMP%\%copy_dir%\conhost.exe*) > nul
(xcopy /Y %_last_build_bin%\console.dll %TEMP%\%copy_dir%\console.dll*) > nul
rem (xcopy /Y %_last_build_bin%\VtPipeTerm.exe %TEMP%\%copy_dir%\VtPipeTerm.exe*) > nul
rem (xcopy /Y %_last_build_bin%\Nihilist.exe %TEMP%\%copy_dir%\Nihilist.exe*) > nul

rem (xcopy /Y %_last_build%\TerminalSettings.dll %TEMP%\%copy_dir%\TerminalSettings.dll*) > nul
rem (xcopy /Y %_last_build%\TerminalConnection.dll %TEMP%\%copy_dir%\TerminalConnection.dll*) > nul
rem (xcopy /Y %_last_build%\TerminalControl.dll %TEMP%\%copy_dir%\TerminalControl.dll*) > nul
rem (xcopy /Y %_last_build%\TerminalApp.dll %TEMP%\%copy_dir%\TerminalApp.dll*) > nul
rem (xcopy /Y %_last_build%\Microsoft.UI.Xaml.dll %TEMP%\%copy_dir%\Microsoft.UI.Xaml.dll*) > nul
rem (xcopy /Y %_last_build%\Microsoft.Toolkit.Win32.UI.XamlHost.dll %TEMP%\%copy_dir%\Microsoft.Toolkit.Win32.UI.XamlHost.dll*) > nul
(xcopy /Y %_last_build%\*.dll %TEMP%\%copy_dir%\*.dll*) > nul
rem (xcopy /Y %_last_build%\*.xbf %TEMP%\%copy_dir%\*.xbf*) > nul
(xcopy /Y %_last_build%\WindowsTerminal.exe %TEMP%\%copy_dir%\WindowsTerminal.exe*) > nul

rem Copy the resources form the package project to the same directory too. We
rem need this to be able to launch. TODO: Find out how to generate this if we're
rem _only_ building the WindowsTerminal project.
(xcopy /Y %_package_output%\resources.pri %TEMP%\%copy_dir%\resources.pri*) > nul

start %TEMP%\%copy_dir%\WindowsTerminal.exe %*
echo Launching %TEMP%\%copy_dir%\WindowsTerminal.exe...