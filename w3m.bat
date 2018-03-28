@echo off
SET PATH=%PATH%;C:\cast\app\w3m_x64\bin
SET HOME=.\
SET TERM=xterm
SET COMSPEC="cmd.exe"
SET SHELL="cmd.exe"
SET CYGWIN=nodosfilewarning
cmd.exe /c bin\w3m.exe http://www.google.co.jp/
rem pause
