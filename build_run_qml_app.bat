QMLProj=QML1.pro

mkdir build
cd build
qmake ../%QMLProj%

mingw32-make -f Makefile.Release