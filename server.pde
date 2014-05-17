NetAddressList myNetAddressList = new NetAddressList();

/*
msgs: 
 /connect  -  string:name   
 /request  - string:sensorName 
 /data  -  string:sensorName 
 /result -string:sensorName, ....
 */

NetAddress myBroadcastLocation; 
String[] sensorNames;
String actSensorName;
SensorReading actualRequest_s;

int timeBetweenRequest = 10; // seconds
int timeLastRequest = 0;

// HashMap<String, SensorReading> collectedData = new HashMap<String, SensorReading>();
ArrayList<SensorReading> collectedData = new ArrayList<SensorReading>();

void setupServer() {
  oscP5 = new OscP5(this, port);
  sensorNames=  sensors.keySet().toArray(new String[0]);
  createNewRequest();
}

void server_update() {
  int secondsPassed = millis()/1000;
  if (secondsPassed - timeLastRequest > timeBetweenRequest) {
    processLastRequest();
    createNewRequest();
    timeLastRequest = secondsPassed;
  }
}

void processLastRequest() {
  OscBundle bundle = new OscBundle();
  println("processing results. number of data: " + collectedData.size());
  for (SensorReading sr : collectedData) {
    OscMessage  m = new OscMessage("/result");
    bundle.add(m);
  }
  oscP5.send(bundle, myNetAddressList);
  collectedData.clear();
}

void createNewRequest() {
  actSensorName = sensorNames[(int) (random(sensorNames.length))];
  actualRequest_s = sensors.get(actSensorName);
  broadcastRequest();
}

void broadcastRequest() {
  OscMessage  m = new OscMessage("/request");
  m.add(actSensorName);
  oscP5.send(m, myNetAddressList);
  println("sending request: "+actSensorName);
}

void server_oscEvent(OscMessage msg) {
  if (msg.addrPattern().equals("/connect")) {
    connect(msg.netAddress().address());
  } 
  else if (msg.addrPattern().equals("/data")) {
    try {
      println("some data coming");
      SensorReading reading = actualRequest_s.createFromMessage(msg);
      if (reading.name.equals(actSensorName))
        //   collectedData.put(msg.netAddress().address(), reading);
        collectedData.add(reading);
    } 
    catch(Exception exc) {
    }
  }
}

void connect(String theIPaddress) {
  if (!myNetAddressList.contains(theIPaddress, port)) {
    myNetAddressList.add(new NetAddress(theIPaddress, port));
    println("### adding "+theIPaddress+" to the list.");
  } 
  else {
    println("### "+theIPaddress+" is already connected.");
  }
  println("### currently there are "+myNetAddressList.list().size()+" remote locations connected.");
}

private void disconnect(String theIPaddress) {
  if (myNetAddressList.contains(theIPaddress, port)) {
    myNetAddressList.remove(theIPaddress, port);
    println("### removing "+theIPaddress+" from the list.");
  } 
  else {
    println("### "+theIPaddress+" is not connected.");
  }
  println("### currently there are "+myNetAddressList.list().size());
}

