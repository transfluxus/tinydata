import ddf.minim.*;
import oscP5.*;
import netP5.*;
import java.awt.*;
import java.awt.event.*;

final boolean SERVER = false;

OscP5 oscP5;
int port = 12000;
NetAddress serverLocation = new NetAddress("192.168.2.132", port); 

HashMap<String, SensorReading> sensors = new HashMap<String, SensorReading>();


void setup() {

  if (!SERVER) {
    minim = new Minim(this);
    microphoneInput = minim.getLineIn (Minim.STEREO, 512);
  }

  //Setup server thingies
  fillSensorReadings();
  if (SERVER)
    setupServer(); 
  else
    setupClient();
}

void draw() {
  if (SERVER) 
    server_update();
  else
    client_update();
}

void keyPressed() {
  //broadcast();
}

void oscEvent(OscMessage msg) {
  if (SERVER) 
    server_oscEvent(msg);
  else 
    client_oscEvent(msg);
  //  println("### received an osc message with addrpattern "+msg.addrPattern()+" and typetag "+msg.typetag());
}

void fillSensorReadings() {
  addSensor(new Microphone(microphoneInput));
  addSensor(new MousePos());
  addSensor(new Space());
  addSensor(new ScreenSize());
}

void addSensor(SensorReading sr) {
  sensors.put(sr.name, sr);
}

void exit() {
  if (!SERVER) {
    sendDisconnect();
    microphoneInput.close();
    minim.stop();
  }
}

