REM uses SPIFFS, ESP32-CAM used
REM 2021-09-15, ESP32-CAM_RTSP firmware
REM burn test ok

:: To erase esp32 completely, do not rely on Arduino IDE and code upload, it has cluster and odd thing when uses FATFS, 
:: unless format SPIFFS or FATFS everytime on the fly
:: xiaolaba, 2020-MAR-02
:: Arduino 1.8.13, esptool and path,


set comport=COM5
::set esptoolpath="%USERPROFILE%\AppData\Local\Arduino15\packages\esp32\tools\esptool_py\3.1.0/esptool.exe"
set esptoolpath="esptool_3.1.0.exe"

REM esptool_4.2.1.exe, this is not working with CP2012, NODEMCU ESP32S why? Arduino IDE 1.8.16
::set esptoolpath="esptool_4.2.1.exe" 

set project=ESP32_leadtek9559gps


::::: erase whole flash of esp32
:: %esptoolpath% --chip esp32 ^
:: --port %comport% ^
:: --baud 921600 ^
:: erase_flash

::pause


REM burn firmware
%esptoolpath% --chip esp32 ^
--port %comport% ^
--baud 921600 ^
--before default_reset ^
--after hard_reset write_flash -e -z ^
--flash_mode dio ^
--flash_freq 80m ^
--flash_size detect ^
0xe000 boot_app0.bin ^
0x1000 %project%.ino.bootloader.bin ^
0x10000 %project%.ino.bin ^
0x8000 %project%.ino.partitions.bin

pause

REM C:\Users\user0\AppData\Local\Arduino15\packages\esp32\tools\esptool_py\4.2.1/esptool.exe 
--chip esp32 
--port COM5 
--baud 921600 
--before default_reset 
--after hard_reset write_flash -e -z 
--flash_mode dio 
--flash_freq 40m 
--flash_size 4MB 
0x1000 C:\Users\user0\AppData\Local\Temp\arduino_build_198761/ESP32_leadtek9559gps.ino.bootloader.bin 
0x8000 C:\Users\user0\AppData\Local\Temp\arduino_build_198761/ESP32_leadtek9559gps.ino.partitions.bin 
0xe000 C:\Users\user0\AppData\Local\Arduino15\packages\esp32\hardware\esp32\2.0.5/tools/partitions/boot_app0.bin 
0x10000 C:\Users\user0\AppData\Local\Temp\arduino_build_198761/ESP32_leadtek9559gps.ino.bin 







