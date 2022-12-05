// copy. https://www.tigoe.com/pcomp/code/Processing/23/
// modified, change baud rate, show com#, dump NMEA for debug, proper handle com port close on exit
// xiaolaba

/* 
 GPS NMEA 0183 reader
 
 reads a GPS string in the NMEA 0183 format and returns lat/long. 
 
 For more on GPS and NMEA, see the NMEA FAQ:
 http://vancouver-webpages.com/peter/nmeafaq.txt
 
 by Tom Igoe
 created 1 June 2006
 */

import processing.serial.*;

int linefeed = 10;       // linefeed in ASCII
int carriageReturn = 13; // carriage return in ASCII
Serial myPort;           // The serial port
int sensorValue = 0;     // the value from the sensor

float latitude = 0.0;    // the latitude reading in degrees
String northSouth;       // north or south?
float longitude = 0.0;   // the longitude reading in degrees
String eastWest;         // east or west?

//GPRMC string
float utc = 0.0;         // egps time
String fix;  // V no fix, A fixed
float groundSpeed = 0.0;
float orientation = 0.0;
String dateFormat;
float magAngle = 0.0;
float magAngleDir = 0.0;
String mode;
String checksum;


boolean debug = true;
//boolean debug = false;


void setup() {
  
  size(600,400);
  background(250);
  
  // List all the available serial ports
  for (int i=0; i<2; i++)
  {
    //println(Serial.list());
    println("Serial.list()" + i, Serial.list()[i]);
  }
  
  // esp32 COM3, at list[1]
  myPort = new Serial(this, Serial.list()[0], 115200);

  // read bytes into a buffer until you get a linefeed (ASCII 13):
  myPort.bufferUntil(carriageReturn);
  
  //swtich2SiRF_protocol();
  //swtich2NMEA_protocol();
  draw();
}




boolean button = false;

int x = 50;
int y = 50;
int w = 100;
int h = 75;


void draw() {
  if (button) {
    background(255);
    stroke(0);
    swtich2SiRF_protocol();
    //swtich2NMEA_protocol();
    text("SiRF_protocol", 40, 240);
  } else {
    background(0);
    stroke(255);
    //swtich2SiRF_protocol();
    swtich2NMEA_protocol();
    text("NMEA_protcol", 40, 240);
}
  
  fill(150);
  rect(x,y,w,h);
  textSize(60);
  text("click rectangle", 150, 100);
}

// When the mouse is pressed, the state of the button is toggled.   
// Try moving this code to draw() like in the rollover example.  What goes wrong?
void mousePressed() {
  if (mouseX > x && mouseX < x+w && mouseY > y && mouseY < y+h) {
    button = !button;
  }  
}

/*
  serialEvent  method is run automatically by the Processing applet
  whenever the buffer reaches the  byte value set in the bufferUntil() 
  method in the setup():
*/

void serialEvent(Serial myPort) { 
//  if (protocol.equals("SiRF") == true) {}
  
//  if (protocol.equals("NMEA") == true) {

    // read the serial buffer:
    String myString = myPort.readStringUntil(linefeed);
    // if you got any bytes other than the linefeed:
    if (myString != null) {
      // parse the string:
      //parseString(myString);
      parseGPRMC(myString);
      
      debug =false;
      
      //xiaolaba, show all com3 read message to console for debug purpose
      if (debug) {
        delay(10);
        print(myString);  //dump NMEA string to terminal
      }
    }
//  }
} 

/*
  parseString takes the string and looks for the $GPGLL header.
  if it finds it, it splits the string into components at the commas,
  and stores them in appropriate variables.
*/


/*



*/

char[] SiRF ={0xA0, 0xA2, 0x00,0x18, 0x81,0x02,0x01,0x01,0x00,0x01,0x01,0x01,0x05,0x01,0x01,0x01,0x00,0x01,0x00,0x01,0x00,0x00,0x00,0x01,0x00,0x00,0x12,0xC0,0x01,0x65,0xB0,0xB3,0x0D,0x0A};
String protocol = "NMEA";

void swtich2NMEA_protocol() {
  myPort.write(byte(SiRF));
  protocol = "SiRF"; //
}

void swtich2SiRF_protocol() {
  myPort.write("$PSRF100,0,9600,8,1,0*0C\r\n");  
  protocol = "NMEA"; //

}


void parseGPRMC(String serialString) {
  // split the string at the commas
  //and convert the sections into integers:
  String items[] = (split(serialString, ','));


  
  // if the first item in the sentence is our identifier, parse the rest:
  if (items[0].equals("$GPRMC") == true) {

    // show the PC & OS time
    println("Today's date is (YYYY/MM/DD) " +year() + "/" + month() + "/" + day() + " " + hour() + ":" + minute() + ":" + second() );
    
    print(serialString);  //dump NMEA string to terminal
    
    //$GPRMC,003808.196,V,,,,,,,110905,,,N*4C
 
    // move the items from the string into the variables:
    utc =     float(items[1]); //hhmmss.ss——000000.00~235959.99
    fix =     items[2];  // A valid, V invalid
    latitude = float(items[3]);
    northSouth = items[4];
    longitude = float(items[5]);
    eastWest = items[6];
    groundSpeed = float(items[7]);
    orientation = float(items[8]);
    dateFormat = (items[9]); // ddmmyy, leadtek 9559, SiRF-III output
    magAngle =  float(items[10]);
    magAngleDir = float(items[11]);

    String mode_checksum[] = splitTokens(items[12], "*"); 
    mode =  mode_checksum[0];  // mode_checksum = M*XX, M is mode(A/D/E/N), * delimiter, XX is checksum in HEX
    checksum = mode_checksum[1];; // HEX ASCII coded 2 digits

    // GPS status invalid
    if (fix.equals("V") == true) println("GPS_status=V, invalid");

    if (fix.equals("V") == true)
//    if (fix.equals("A") == true)  // GPS status valid
    {
      println("NMEA string decoded,\r\n" +
        "utc=" + utc + "\r\n" + 
        ", GPS_status=" + fix + " (V=invalid, A=valid) " +
        ", lat=" +latitude + northSouth + 
        ", lon=" +longitude + eastWest + 
        ", speed=" + groundSpeed + 
        ", orientation=" + orientation + 
        ", datefomat (ddmmyy)=" + dateFormat +
        ", magAngle=" + magAngle + 
        ", magAngleDir=" + magAngleDir + "\r\n" +
        ", mode=" + mode + " (A: Self_fix, D: Diferrential, E: Estimated, N: no_good)" +
        ", checksum=0x" + checksum + 
        "\r\n"
      );
    }


    
  }
}


void parseString(String serialString) {
  // split the string at the commas
  //and convert the sections into integers:
  String items[] = (split(serialString, ','));
  // if the first item in the sentence is our identifier, parse the rest:
  if (items[0].equals("$GPGLL") == true) {
    // move the items from the string into the variables:
    latitude = float(items[1]);
    northSouth = items[2];
    longitude = float(items[3]);
    eastWest = items[4];
    println(latitude + northSouth + "," +longitude + eastWest);
  }
}


void exit() {
    println("Exiting program");
    myPort.stop();  // stoping serial port.
   //your Code above. 
   super.exit();
}
