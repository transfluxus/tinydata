String name="ra";

SensorReading actualRequest = null;
SensorReading nextRequest = null;

boolean readingDone=true;

void setupClient() {
  oscP5 = new OscP5(this, port);
  // connect msg
  OscMessage  m = new OscMessage("/connect");
  m.add(name);
  oscP5.send(m, serverLocation);
}

void client_update() {
  println("client_update");
  
  if (actualRequest!=null && !readingDone) {
   println("actualRequest.execute();"); 
    actualRequest.execute();
  }
}

void client_oscEvent(OscMessage msg) {
  println("client: client_oscEvent");
  
  String sensorName = msg.get(0).stringValue();
  println("client: sensorname: " + sensorName);
  if (msg.addrPattern().equals("/request")) {
    println("client: msg.addrpattern.....");
    
    if (readingDone) {
      println("client: reading done...");
      actualRequest = sensors.get(sensorName);
      readingDone = false;
      actualRequest.init();
    }
    else 
      nextRequest= sensors.get(sensorName);
  }
  else if (msg.addrPattern().equals("/result")) {
    SensorReading sr =  sensors.get(sensorName);
    sr.createFromMessage(msg);
    sr.print();
  }
}

