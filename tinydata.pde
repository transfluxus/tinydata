import oscP5.*;
import netP5.*;

final boolean SERVER = true;

OscP5 oscP5;
int port = 12000;
NetAddress serverLocation = new NetAddress("192.168.2.132", port); 

HashMap<String, SensorReading> sensors = new HashMap<String, SensorReading>();

void setup() {
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
  SensorReading s = new MousePos();
  sensors.put(s.name,s);
}

