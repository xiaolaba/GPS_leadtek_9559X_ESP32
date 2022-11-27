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
pause