// This #include statement was automatically added by the Particle IDE.
#include <simple-OSC.h> // Make sure to install this via Particle Library installer, copy/paste won't work


/* OSC */

UDP udp;
IPAddress outIp(XX,XXX,XX,XXX); // CHANGE THIS BASED ON YOUR NETWORK (FIND IP IN NETWORK SETTINGS)
unsigned int outPort = 1234; // MATCH THIS TO PORT # IN PROCESSING
unsigned int inPort = 8001;

/* OSC VARIABLES */
float flexValue0;
float flexValue1;
float flexValue2;



/* FLEX SENSOR */
int flexSensorPin0 = A0; //analog pin 0
int flexSensorPin1 = A1; //analog pin 1
int flexSensorPin2 = A2; //analog pin 2

void setup(){
    
    /* OSC */
    Serial.begin(115200); // faster data rate
    udp.begin(inPort); //necessary even for sending only
    Serial.println("");
    Serial.println("WiFi connected");
    IPAddress ip = WiFi.localIP();
    
}

void loop(){

    flexValue0 = analogRead(flexSensorPin0);
    flexValue1 = analogRead(flexSensorPin1);
    flexValue2 = analogRead(flexSensorPin2);
    
    /* OSC */
    
    // set up the message
    OSCMessage outMessage("/photon");

    outMessage.addFloat(flexValue0);
    outMessage.addFloat(flexValue1);
    outMessage.addFloat(flexValue2);
 
    
    // finish the message
    outMessage.send(udp,outIp,outPort);
}