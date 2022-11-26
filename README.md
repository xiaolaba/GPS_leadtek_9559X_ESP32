# GPS_leadtek_9559X_ESP32
old GPS bluetooth device, serial output 19200 baud N81, NMEA-0183 or SiRF bainary

very old device, 

specification,

```
Specifications
Chipset : GSW3 SiRFStarIII technology

SiRF GSW3
Protocol : NMEA-0183 (default) / SiRF Binary
Baud rate : 19200bps (default)

Datum WGS-84 (default) / User configurable
Protocol message Default: GGA (1sec), GSA(5sec), GSV(5sec), RMC(1sec), VTG(1sec)

General
Frequency : L1, 1575.42MHz
C/A code : 1.023 MHz chip rate
Channels : 20

Accuracy
Position : 10 meters, 2D RMS
           5 meters 2D RMS, WAAS corrected
           < 5 meters (50%), DGPS corrected
Velocity : 0.1 m/s
Time :     1 microsecond synchronized to GSP time

Time to first fix (Open sky and stationary)
Reacquisition : 0.1 sec. average
Hot start : 8 sec. average typical TTFF
Warm start : 38 sec. average typical TTFF
Cold start : 42 sec. average typical TTFF

Power
Main power input 5 ± 5%(10%)V DC input Power
consumption ~390 mW(continuous mode)
Backup power 1.5 ± 10%V DC input
Operation Time 11 hours (1000mAh Li-Ion battery)

Time 1pps pulse
Level 3.3V TTL
Pulse duration 1 μs
Time reference At the pulse’s positive edge
Measurements Aligned to GPS second, ±1 microsecond
Interface
Power recharge Mini-USB connector

Connector for
external antenna
GPS communications
interface
Bluetooth
MMCX
TTTL level serial

Bluetooth
MMCX
TTTL level serial port
Frequency 2400MHz to 2483.5zMHz
Modulation Method GFSK, 1Mbps, 0.5BT Gaussian
Maximum Data Rate Asynchronous: 723.2kbps/57.6kbps
Synchronous: 433.9kbps/433.9kbps
Transmission Power
(Maximum)
4dBm (Class2)
Hoping 1600hops/sec, 1MHz channel space
Receiving Signal
Range
Receiver IF
Frequency
Baseband Crystal
OSC
-84 to -15dBm
1.5MHz center frequency
16MHz
Compliant Bluetooth specification v1.2
Profile Series Port Profile (SPP)
Bluetooth Operation Range : 10M

LED
LED 1

Color Blue Flashing Blue Red
BT active Yes No -
Low power - - Yes

LED 2
Color Green Flashing Green Orange
GPS fix status No Yes -
Battery charging - - Yes

```



