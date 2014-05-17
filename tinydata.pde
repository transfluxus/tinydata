import oscP5.*;
import netP5.*;
import java.awt.*;
import java.awt.event.*;

final boolean SERVER = true;

OscP5 oscP5;
int port = 12000;
NetAddress serverLocation = new NetAddress("192.168.2.132", port); 

HashMap<String, SensorReading> sensors = new HashMap<String, SensorReading>();

void setup() {
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
  println("### received an osc message with addrpattern "+msg.addrPattern()+" and typetag "+msg.typetag());
}

void fillSensorReadings() {
  //SensorReading microphone = new Microphone();
  //sensors.put(microphone.name, microphone);
  SensorReading mousePos = new MousePos();
  sensors.put(mousePos.name, mousePos);
  //  SensorReading ambienceLight = new AmbienceLight();
  //  sensors.put(ambienceLight.name, ambienceLight);
}

void exit() {
  if (!SERVER)
    sendDisconnect();
}

