@echo off
set QMLProj=
set QMLProj=%QMLProj%; QML1
rem set QMLProj=%QMLProj%; QML2

for %%a in (%QMLProj%) do (
	mkdir build_%%a
	cd build_%%a
	qmake ../%%a.pro -spec win32-g++ "CONFIG+=debug" "CONFIG+=qml_debug"

	rem mingw32-make -f Makefile.Debug
	mingw32-make -f Makefile.Release
	cd ..
)

