
String name = "ambience";

SensorReading actualRequest = null;
SensorReading nextRequest = null;

boolean readingDone = false;

void setupClient() {
  oscP5 = new OscP5(this, port);
  // connect msg
  OscMessage  m = new OscMessage("/connect");
  m.add(name);
  oscP5.send(m, serverLocation);
}

void client_update() {
  if (actualRequest!=null) {    
    actualRequest.execute();
  }
}

void client_oscEvent(OscMessage msg) {
  if (msg.addrPattern().equals("/sensorRequest")) {
    String sensorName = msg.get(0).stringValue();
    if (readingDone) 
      actualRequest = sensors.get(sensorName);
    else 
      nextRequest = sensors.get(sensorName);
  }
}

