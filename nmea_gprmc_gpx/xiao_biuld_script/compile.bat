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

 
rem 用Gcc, 沒有GDB 除錯資料的編譯
::gcc -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp
 
cd ..\nmea_gprmc\src

pause

rem 用G++, 包含GDB 除錯資料的編譯
g++ -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp

::g++ -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp

::g++ -g -static -o txt2gpx.exe main.cpp txt2gpx.cpp china_shift.cpp

::g++ -fexec-charset=UTF-8 -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp

::g++ -fexec-charset=GB-2313 -g -static -o gprmc.exe main.cpp gprmc.cpp txt2gpx.cpp china_shift.cpp

::copy gprmc.exe ..\..\xiao_biuld_script

move gprmc.exe ..\..\xiao_biuld_script


cd ..\..\xiao_biuld_script

pause


::::::::: gprmc.exe is compiled, build gpx

:: change dos console code page to utf-8, otherwise help string with mess
chcp 65001

:: default code code BIG5, Taiwan win10
:: chcp 936

::::: convert nema to gpx, offset CHINA gps cordinated
::gprmc.exe recv_2022-11-26_14-30-07.nema gps.txt 0284

:: convert nema to gpx, matched the real worldwide cooridnates, xiaolaba 2022-NOV-26
gprmc.exe nmea.txt nmea_parse.txt 8484

:: display help only, utf-8, simplified Chinese char
gprmc.exe

::pause
@echo.
@echo "nmea_parse.txt & nmea_parse.txt.gpx is created"
@echo download google earth pro desktop for widnows, https://www.google.com/earth/about/versions/#download-pro
@echo import nmea_parse.txt.gpx  to google earth pro, you will see your tracks and location

@echo.
@echo "生成兩個文件 nmea_parse.txt & nmea_parse.txt.gpx"
@echo 下載 google earth pro desktop for widnows, https://www.google.com/earth/about/versions/#download-pro
@echo 匯入 import nmea_parse.txt.gpx 到 google earth pro, 定位和路徑可視

@echo.
@echo how to import gpx
@echo https://www.google.com/earth/outreach/learn/importing-global-positioning-systems-gps-data-in-google-earth/

pause