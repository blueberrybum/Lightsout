import ddf.minim.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import javax.sound.sampled.*;
import spacebrew.*;
import cc.arduino.*;



String server="sandbox.spacebrew.cc";
String name="My Lovely Lady Lumps";
String description ="Client that sends and receives a virtual dice roll - a number between 1 and 6.";
int bright = 0; 
Minim minim;
AudioPlayer billionaire;

Spacebrew sb;

// Keep track of our current place in the range


void setup() {
size(400, 200);
background(0);
minim = new Minim(this);
//load all of the music files
billionaire = minim.loadFile("billionaire.mp3");
// instantiate the spacebrewConnection variable
sb = new Spacebrew( this );

// declare your publishers
sb.addPublish( "make me","range", bright ); 
sb.addSubscribe( "alexOutput", "range");

sb.connect(server, name, description );

}

void draw() {
background(50);
stroke(0);
background( bright / 4, bright / 4, bright / 4 );
if(bright >= 940){
background(0);
billionaire.play();

}
else{
billionaire.pause();
}

println(bright);
}

void mouseClicked() {

sb.send("alexOutput", (bright));
}


void onCustomMessage( String name, String type, String value ){
println("got " + type + " message " + name + " : " + value);


  
}


void onRangeMessage( String name, int value ) {
  println("got name "+name);
  if (name.equals("alexOutput")) {
    bright = value;
  }
}

