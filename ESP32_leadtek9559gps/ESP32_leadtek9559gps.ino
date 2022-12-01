// https://esp32.com/viewtopic.php?t=7889

//This example code is in the Public Domain (or CC0 licensed, at your option.)
//By Victor Tchistiak - 2019
//
//This example demostrates master mode bluetooth connection and pin
//it creates a bridge between Serial and Classical Bluetooth (SPP)
//this is an extention of the SerialToSerialBT example by Evandro Copercini - 2018
//

#include "BluetoothSerial.h"

BluetoothSerial SerialBT;

//String MACadd = "AA:BB:CC:11:22:33";
//uint8_t address[6]  = {0xAA, 0xBB, 0xCC, 0x11, 0x22, 0x33};

// my leadtek 9559 GPS MAC address
uint8_t address[6] = {0x00, 0x02, 0x78, 0x14, 0x0B, 0xFC};

String name = "Leadtek 9559 series BT GPS";
char *pin = "0000"; //<- standard pin would be provided by default

bool connected;

void setup() {
  Serial.begin(115200);
  SerialBT.begin("ESP32test", true);
  SerialBT.setPin(pin);
  Serial.println("The device started in master mode, make sure remote BT device is on!");
  
  // connect(address) is fast (upto 10 secs max), connect(name) is slow (upto 30 secs max) as it needs
  // to resolve name to address first, but it allows to connect to different devices with the same name.
  // Set CoreDebugLevel to Info to view devices bluetooth address and device names
  
  connected = SerialBT.connect(name);
  //connected = SerialBT.connect(address);

  delay(100);
  
  if(connected) {
    Serial.println("Connected Succesfully!");
  } else {
    while(!SerialBT.connected(10000)) {
      Serial.println("Failed to connect. Make sure remote device is available and in range, then restart app.");
    }
  }
  
  // disconnect() may take upto 10 secs max
  SerialBT.flush();
  if (SerialBT.disconnect()) {
    Serial.println("Disconnected Succesfully!");
  }

  //disconnect_bluetooth();

//  delay(1000); // not working !!
//  delay(2000); // working ??
//  delay(3000); // not working ? a must, otherwise leadtek GPS failed connection
//  delay(5000); // not working ? a must, otherwise leadtek GPS failed connection

  
  // this would reconnect to the name(will use address, if resolved) or address used with connect(name/address).
  //SerialBT.connect(address);
  SerialBT.connect();
}

void loop() {
  if (Serial.available()) {
    SerialBT.write(Serial.read());
  }
  if (SerialBT.available()) {
    Serial.write(SerialBT.read());
  }
  //delay(20);
  
}


void disconnect_bluetooth()
{
  delay(1000);
  Serial.println("BT stopping");
  SerialBT.println("Bluetooth disconnecting...");
  delay(1000);
  SerialBT.flush();
  SerialBT.disconnect();
  SerialBT.end();
  Serial.println("BT stopped");
  delay(1000);
//  bluetooth_disconnect = false;
}
