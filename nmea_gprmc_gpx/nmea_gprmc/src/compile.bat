rem //-----------------
rem compile.bat
rem //-----------------
rem ������� -static �x�, Windows �h��, ����ṩ
rem path = c:\MinGW\bin ��
rem �}�u libgcc_s_dw2-1.dll �����Y�ϊA
rem JUL/31/2011, xiaolaba

:: change dos console code page to utf-8, otherwise help string with mess
::chcp 65001

:: default code code BIG5, Taiwan win10
:: chcp 936


:: //-----------------
:: // set_path.bat
:: //-----------------
 
set compiler=c:\MinGW\bin

set path=%compiler%;%path%

 
rem ��Gcc, �]��GDB ���e�Y�ϵľ��g
::gcc -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp
 
::cd ..\nmea_gprmc\src

::pause


rem ��G++, ����GDB ���e�Y�ϵľ��g
g++ -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp

::g++ -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp

::g++ -g -static -o txt2gpx.exe main.cpp txt2gpx.cpp china_shift.cpp

::g++ -fexec-charset=UTF-8 -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp

::g++ -fexec-charset=GB-2313 -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp

::copy gprmc.exe ..\

::cd ..\

pause