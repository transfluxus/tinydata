String name="ra";

SensorReading actualRequest = null;
SensorReading nextRequest = null;

boolean readingDone=false;

void setupClient() {
  oscP5 = new OscP5(this, port);
  // connect msg
  OscMessage  m = new OscMessage("/connect");
  m.add(name);
  oscP5.send(m, serverLocation);
}

void client_update() {
  if (actualRequest!=null && !readingDone) 
    actualRequest.execute();
}

void client_oscEvent(OscMessage msg) {
  String sensorName = msg.get(0).stringValue();
  if (msg.addrPattern().equals("/sensorRequest")) {
    if (readingDone) 
      actualRequest = sensors.get(sensorName);
    else 
      nextRequest= sensors.get(sensorName);
  }
  else if (msg.addrPattern().equals("/result")) {
    SensorReading sr =  sensors.get(sensorName);
    sr.createFromMessage(msg);
    sr.print();
  }
}

