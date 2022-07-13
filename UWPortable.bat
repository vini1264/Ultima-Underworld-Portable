::	This is the uncompiled version of UWPortable.exe
:: 
::	Distributed under the terms of the GNU General Public License. 
::	The Ultima Underworld launcher program is free software: 
::	you can redistribute it and/or modify it under the terms of 
::	the GNU General Public License as published by the Free Software Foundation, 
::	either version 3 of the License, or (at your option) any later version.
::	
::	The Ultima Underworld Portable launcher program  is distributed in the hope that 
::	it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
::	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
::	GNU General Public License for more details.
::	
::	You should have received a copy of the GNU General Public License
::	along with the Ultima Underworld Portable launcher program.  
::	If not, see <http://www.gnu.org/licenses/>.
::
::	Note that the software distribution "Ultima Underworld Portable" contains work of several
::	other sources listed below.
::
::	Data from the respective PC games "Ultima Underworld (1992)" and "Ultima Underworld 2 (1993)" 
::	Copyright by Blue Sky Productions, Origin and Electronic Arts Entertainment.
::
::  Code from this batch file was taken from the
::  System Shock Portable Tool made by Nicolai Sandow
::  and modified to make it work with Ultima Underworld
::  https://www.systemshock.org/index.php?topic=211.0
::  
::	John Glassmyer's mouselook modification from Ultima Hacks
::	https://github.com/JohnGlassmyer/UltimaHacks
::
::	Portuguese translation by Israel A. Possoli
::  https://github.com/israelpossoli/ultimaunderworld-ptbr
::
::  Lights patch by Gigaquad
::  http://bootstrike.com/Uw1/downloads.php
::
::	DOSbox Staging, enhanced version of the original DOSbox
::	https://dosbox-staging.github.io

::Setting up the window...
@echo off
COLOR 1F
mode con: cols=72 lines=26
::Init vars
SET uwpver=1.0
::Hey, which game is this?
TITLE Ultima Underworld Portable %uwpver%

::-----------------------------------------------------------------------

IF EXIST ./data/game/UW/UW.EXE (
ECHO.
ECHO   Welcome %username%. An adventure is waiting for you.
ECHO.
) ELSE (
ECHO.
ECHO   Ultima Underworld is not installed  
Echo.
ECHO   Copy game.gog file from the GOG installation and run the extractor
ECHO.
PAUSE
GOTO EOF
)
PAUSE
REM SET target=main
REM SET delay=1
REM GOTO WAIT

::-----------------------------------------------------------------------

::Setting up the window...
@echo off
COLOR 1F
mode con: cols=72 lines=26

:MAIN
CLS
COLOR 1F
ECHO.          
ECHO             Main Menu           
ECHO.
IF EXIST ./data/uwp/flags/dosbox_enabled ( ECHO  1: Start Ultima Underworld 1 )
IF EXIST ./data/uwp/flags/dosbox2_enabled ( ECHO  2: Start Ultima Underworld 2 )

ECHO  o: Options
ECHO  q: Quit
ECHO.
set choice=
set /p choice=
if not "%choice%"=="" set choice=%choice:~0,1%
if "%choice%"=="1" GOTO DOSBOX
if "%choice%"=="2" GOTO DOSBOX2
if "%choice%"=="o" GOTO OPTIONS
if "%choice%"=="q" GOTO EOF
ECHO.
ECHO "%choice%" is not a valid choice. Please try again.
PAUSE
GOTO MAIN

:DOSBOX
IF EXIST ./data/uwp/flags/dosbox_enabled ( START "" /d data\dosbox dosbox.exe -conf uw.conf)
GOTO EOF

:DOSBOX2
IF EXIST ./data/uwp/flags/dosbox2_enabled ( START "" /d data\dosbox dosbox.exe -conf uw2.conf)
GOTO EOF

:OPTIONS
CLS
COLOR 1F
ECHO.   
ECHO              Options              
ECHO.

::Show toggle for mouselook mod
IF EXIST ./data/uwp/flags/mouselook_enabled (
ECHO  e: Disable mouselook mod for Ultima Underworld 1 and 2
) ELSE (
ECHO  e: Enable mouselook mod for Ultima Underworld 1 and 2
)

::Show toggle for portuguese translation
IF EXIST ./data/uwp/flags/ptbr_enabled (
ECHO  p: Disable portuguese translation for Ultima Underworld 1
) ELSE (
ECHO  p: Enable portuguese translation for Ultima Underworld 1
)

::Show toggle for brightness
IF EXIST ./data/uwp/flags/shades_increased (
ECHO  s: Set brightness to default
) ELSE (
ECHO  s: Increase brightness for UW 1 and 2
)

ECHO  m: Main menu
ECHO  q: Quit
ECHO.
set choice=
set /p choice=
if not "%choice%"=="" set choice=%choice:~0,1%
if "%choice%"=="e" GOTO UWLook
if "%choice%"=="p" GOTO PTBR
if "%choice%"=="s" GOTO SHADES
if "%choice%"=="m" GOTO MAIN
if "%choice%"=="q" GOTO EOF

:UWLook 
::Toggle mouselook mod
IF EXIST ./data/uwp/flags/mouselook_enabled (
DEL .\data\uwp\flags\mouselook_enabled
START /d data 7z.exe x -y mods/OriginalExe.7z -ogame\UW
START /d data 7z.exe x -y mods/OriginalExe2.7z -ogame\UW2
ECHO flag >> data/uwp/flags/OriginalExe
CLS
ECHO.
ECHO  Mouselook mod for Ultima Underworld 1 and 2 was disabled.
ECHO.
PAUSE
) ELSE (
IF EXIST ./data/uwp/flags/OriginalExe ( DEL .\data\uwp\flags\OriginalExe )
ECHO flag >> data/uwp/flags/mouselook_enabled
START /d data 7z.exe x -y mods/mouselook.7z -ogame\UW
START /d data 7z.exe x -y mods/mouselook2.7z -ogame\UW2
CLS
ECHO.
ECHO  Mouselook mod for Ultima Underworld 1 and 2 has been enabled.
ECHO  Press '`' Backquote in game to use mouselook.
ECHO.
PAUSE
)
GOTO OPTIONS

:PTBR
::Toggle portuguese translation
IF EXIST ./data/uwp/flags/ptbr_enabled (
DEL .\data\uwp\flags\ptbr_enabled
START /d data 7z.exe x -y mods/OriginalStrings.7z -ogame\UW\DATA
ECHO flag >> data/uwp/flags/OriginalTranslation
CLS
ECHO.
ECHO  Portuguese translation for Ultima Underworld 1 was disabled.
ECHO.
PAUSE
) ELSE (
IF EXIST ./data/uwp/flags/OriginalTranslation ( DEL .\data\uwp\flags\OriginalTranslation )
ECHO flag >> data/uwp/flags/ptbr_enabled
START /d data 7z.exe x -y mods/ptbr_strings.7z -ogame\UW\DATA
CLS
ECHO.
ECHO  Portuguese translation for Ultima Underworld 1 has been enabled.
ECHO.
PAUSE
)
GOTO OPTIONS

:SHADES
::Toggle brightness
IF EXIST ./data/uwp/flags/shades_increased (
DEL .\data\uwp\flags\shades_increased
START /d data 7z.exe x -y mods/OriginalShades.7z -ogame\UW\DATA
START /d data 7z.exe x -y mods/OriginalShades2.7z -ogame\UW2\DATA
ECHO flag >> data/uwp/flags/OriginalShades
CLS
ECHO.
ECHO  Ultima Underworld 1 and 2 brightness set to default
ECHO.
PAUSE
) ELSE (
IF EXIST ./data/uwp/flags/OriginalShades ( DEL .\data\uwp\flags\OriginalShades )
ECHO flag >> data/uwp/flags/shades_increased
START /d data 7z.exe x -y mods/NewShades.7z -ogame\UW\DATA
START /d data 7z.exe x -y mods/NewShades.7z -ogame\UW2\DATA
CLS
ECHO.
ECHO  Ultima Underworld 1 and 2 Brightness increased
ECHO.
PAUSE
)
GOTO OPTIONS

::-----------------------------------------------------------------------

:EOF
::Good night, Avatar.
EXIT