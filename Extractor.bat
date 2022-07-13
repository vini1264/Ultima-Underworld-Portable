::Setting up the window...
@echo off
COLOR 1F
mode con: cols=72 lines=26
::Hey, which game is this?
TITLE Ultima Underworld Extractor

::-----------------------------------------------------------------------

IF EXIST ./data/game/INSTALL1.EXE (
ECHO.
ECHO   Ultima Underworld is already installed
ECHO.
PAUSE
GOTO EOF
)

IF EXIST game.gog (
ECHO.
ECHO   gog.game has been detected, installation will proceed
ECHO.
PAUSE
START /d data 7z.exe x ../game.gog -x!*.bat -ogame
cls
ECHO.
ECHO   Ultima Underworld was successfully installed, close the program.
ECHO.
PAUSE
GOTO EOF
) ELSE (
ECHO.
ECHO   game.gog is not present in this folder
Echo.
ECHO   Copy the game.gog file from your GOG installation
ECHO.
PAUSE
GOTO EOF
)

:EOF
::Good night, Avatar
EXIT