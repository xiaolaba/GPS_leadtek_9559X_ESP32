rem //-----------------
rem compile.bat
rem //-----------------
rem 如果不用 -static 選項, Windows 環境, 必須提供
rem path = c:\MinGW\bin 或
rem 複製 libgcc_s_dw2-1.dll 到本資料夾
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

 
rem 用Gcc, 沒有GDB 除錯資料的編譯
::gcc -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp
 
::cd ..\nmea_gprmc\src

::pause


rem 用G++, 包含GDB 除錯資料的編譯
g++ -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp

::g++ -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp

::g++ -g -static -o txt2gpx.exe main.cpp txt2gpx.cpp china_shift.cpp

::g++ -fexec-charset=UTF-8 -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp

::g++ -fexec-charset=GB-2313 -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp

::copy gprmc.exe ..\

::cd ..\

pause