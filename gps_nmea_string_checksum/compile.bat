rem //-----------------
rem compile.bat
rem //-----------------
rem 如果不用 -static 選項, Windows 環境, 必須提供
rem path = c:\MinGW\bin 或
rem 複製 libgcc_s_dw2-1.dll 到本資料夾
rem JUL/31/2011, xiaolaba

:: change dos console code page to utf-8, otherwise help string with mess
chcp 65001

:: default code code BIG5, Taiwan win10
:: chcp 936


:: //-----------------
:: // set_path.bat
:: //-----------------
 
set compiler=c:\MinGW\bin

set path=%compiler%;%path%

set project=gps_nmea_string_checksum

 
rem 用Gcc, 沒有GDB 除錯資料的編譯
gcc -static -o %project%.exe %project%.c

%project%.exe
::pause

rem 用G++, 包含GDB 除錯資料的編譯
::g++ -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp

::pause