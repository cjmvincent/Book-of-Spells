@echo off

echo Stopping print spooler.

net stop spooler

echo deleting temp files.

del %systemroot%\system32\spool\printers\* /q

echo Starting print spooler.

net start spooler