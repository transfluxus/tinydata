NetAddressList myNetAddressList = new NetAddressList();

/*
msgs: 
 /connect  -  string:name   
 /dataSend  -  ...
 /sensorRequest  -  
 */

NetAddress myBroadcastLocation; 
String[] sensorNames;

int timeLastRequest = 0;
int timeBetweenRequest = 30; // seconds

void setupServer() {
  oscP5 = new OscP5(this, port);
 sensorNames=  sensors.keySet().toArray(new String[0]);
}

void server_update() {
  if(second() - timeLastRequest > timeBetweenRequest) {
    processLastRequest();
    createNewRequest();
  }
}

void processLastRequest() {
  
}

void createNewRequest() {
  String sensorName = sensorNames[(int) (random(sensorNames.length))];
//  actualRequest_s = sensors.get(sensorName);
}

void broadcast() {
  OscMessage  m = new OscMessage("/broadcast", new Object[] {
    "Hello"
  }
  );
  oscP5.send(m, myNetAddressList);
}

void server_oscEvent(OscMessage msg) {
  if (msg.addrPattern().equals("/connect")) {
    println(msg.netAddress());
    connect(msg.netAddress().address());
  }
}

private void connect(String theIPaddress) {
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

