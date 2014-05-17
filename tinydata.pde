import oscP5.*;
import netP5.*;

final boolean SERVER = false;

OscP5 oscP5;
int port = 12000;
NetAddress serverLocation = new NetAddress("192.168.2.132", port); 

HashMap<String, SensorReading> sensors = new HashMap<String, SensorReading>();

//Mouse tracking:
import java.awt.*;
import java.awt.event.*;
 
 Robot robot;

void setup() {
  //Mouse tracking:
    try { 
    robot = new Robot();
    robot.setAutoDelay(0);
  } 
  catch (Exception e) {
    e.printStackTrace();
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
  println("### received an osc message with addrpattern "+msg.addrPattern()+" and typetag "+msg.typetag());
}

void fillSensorReadings() {
  //SensorReading microphone = new Microphone();
  //sensors.put(microphone.name, microphone);
  
  SensorReading ambienceLight = new AmbienceLight();
  sensors.put(ambienceLight.name, ambienceLight);
}

