import spacebrew.*;
import processing.serial.*;
import cc.arduino.*;

String server = "sandbox.spacebrew.cc";
String name = "My Humps" + floor(random(1000));
String description = "";

int bright = 0; // the value of the phtocell we weill send over spacebrew

Spacebrew spacebrewConnection; // Spacebrew connection object
Serial myPort; // Serial port object 

void setup() {
size(400, 200);

// instantiate the spacebrew object
spacebrewConnection = new Spacebrew( this );

// add each thing you publish to
spacebrewConnection.addPublish("brightness","range", bright ); 

// connect to spacebrew
spacebrewConnection.connect(server, name, description );

// print list of serial devices to console
println(Serial.list());
myPort = new Serial(this, "/dev/tty.usbmodem1421", 9600); // CONFIRM the port that your arduino is connect to
myPort.bufferUntil('\n');
}

void draw() {

background( bright / 4, bright / 4, bright / 4 );


if (bright < 930) { fill(225, 225, 225); }
// otherwise make text white
else { fill(25, 25, 25); }


textAlign(CENTER);
textSize(16);

if (spacebrewConnection.connected()) {

text("Connected as: " + name, width/2, 25 ); 

// print current bright value to screen
textSize(60);
text(bright, width/2, height/2 + 20); 
}
else {
text("Not Connected to Spacebrew", width/2, 25 ); 
}
}

void serialEvent (Serial myPort) {
// read data as an ASCII string:
String inString = myPort.readStringUntil('\n');

if (inString != null) {
// trim off whitespace
inString = trim(inString);

// convert value from string to an integer
bright = int(inString); 

// publish the value to spacebrew if app is connected to spacebrew
if (spacebrewConnection.connected()) {
spacebrewConnection.send( "brightness", bright);
}
}
}
