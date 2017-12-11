/* OSC */
import netP5.*;
import oscP5.*;

OscP5 oscP5;


/* OSC VARIABLES */
float flexValue0;
float openThreshold0 = 1000; // calibrate this number based on sensor readings

float flexValue1;
float openThreshold1 = 400; // calibrate this number based on sensor readings

float flexValue2;
float openThreshold2 = 1100; // calibrate this number based on sensor readings


/* IMAGES TO SHOW */
int counter = 20; // number of images, would be cooler if it could count the folder
PImage[] imgs = new PImage[counter]; // declary the array, create 20 spots


void setup() {
  size(1680, 1025);
  //size(400, 400);
  background(0);
  frameRate(18);

  oscP5 = new OscP5(this, 1234);

  // load all the images - MUST BE NAMED photo*.jpg
  for (int i = 1; i < counter; i++) {
    imgs[i] = loadImage("photo" + i + ".jpg");
  }
}

void draw() {


  println("flexValue0: "+flexValue0);
  println("flexValue1: "+flexValue1);
  println("flexValue2: "+flexValue2);

  // Use this function calibrate 1x1 - change the variable
  //  if (flexValue2 > openThreshold2) {
  //    imageDrawer();
  //  } else {
  //    background(0);
  //  }

  if (flexValue0 > openThreshold0 || flexValue1 > openThreshold1 || flexValue2 > openThreshold2) {
    imageDrawer();
  } else {
    background(0);
  }
}

void imageDrawer() {

  // get a random number between 0 and counter 
  float randomIndexFloat = random(1, counter);
  int randomIndex = int(randomIndexFloat);
  //println(randomIndex);
  image(imgs[randomIndex], 0, 0); // draw the default image

}

/* incoming osc message are forwarded to the oscEvent method. */
void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("/photon")==true) {

    //parse a message that's a float
    flexValue0 = theOscMessage.get(0).floatValue();
    flexValue1 = theOscMessage.get(1).floatValue();
    flexValue2 = theOscMessage.get(2).floatValue();

    return;
  }
}