#include <stdio.h> //wordpress 自動去除 < > 及內容, 解決辦法, 前後加空格
#include <stdlib.h>
#include <stdbool.h>	// bool
#include <stdint.h>		// byte



//char gpsMessage[]= "$PSRF100,0,9600,8,1,0*0C";	// SiRF set baud rate 9600, N81
//char gpsMessage[]= "$PSRF100,0,19200,8,1,0*39";	// SiRF set baud rate 19200, N81
//char gpsMessage[]= "$PSRF100,0,38400,8,1,0*3C";	// SiRF set baud rate 38400, N81
//char gpsMessage[]= "$PSRF100,0,57600,8,1,0*37";	// SiRF set baud rate 57600, N81
//char gpsMessage[]= "$PSRF100,0,115200,8,1,0*04";	// SiRF set baud rate 115200, N81


//char gpsMessage[] ="$GPRMC,062946.831,A,2523.0535,N,11657.9581,E,0.17,129.03,261122,,,A*64";
char gpsMessage[] ="$GPRMC,062942.831,A,22523.0533,N,11657.9584,E,0.22,61.16,261122,,,A*6E";



static const char hex[] = "0123456789ABCDEF";

bool gpsChecksumOk(const char *gpsMessage) {
  
  printf ("%s\n\nReal log of GPS NMEA0183 message\n", gpsMessage);
  printf ("checksum calcualtion, XOR all char in between $..*\n");
  printf ("last 2 char, HEX value of checksum\n");
  printf ("let us try,\n\n");

  
  uint8_t max = 90; // NMEA says 82, but there could have longer proprietary messages
  if (*gpsMessage != '$') return false;
  char checksum = 0;
  for(;;) {
    if (--max <= 0) return false; // Protect from run away if no *
    char b = *++gpsMessage;
    if (b == '*') break; 
    checksum ^= b;	// XOR each char of the string in between $..*
	printf("%c",b);
  }
  
  printf("\n\nMy calculated checksum = 0x%x, ",checksum);
 
  unsigned char digit0 = hex[(checksum & 0xf0) >> 4];
  unsigned char digit1 = hex[(checksum & 0x0f)];
  if (gpsMessage[1] != digit0 || gpsMessage[2] != digit1) {
	  printf("!!!! soemthing wrong !!!\n");
  } else {
	  printf("checksum OK\n");
  }
  return true;
}


int main() {
	printf("\nGPS NMEA message checksum, experiment by xiaolaba\n\n");
	gpsChecksumOk(gpsMessage);
	
	printf("Press ENTER to Continue\n"); getchar();
	printf("byebye\n");  
	
	return 0;
}