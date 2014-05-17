import oscP5.*;
import netP5.*;


OscP5 oscP5;
NetAddressList myNetAddressList = new NetAddressList();
int broadcastPort = 12000;

NetAddress serverLocation = new NetAddress("192.168.2.132",12000); 

/*
msgs: 
 /connect  -  string:name   
 /dataSend  -  ...
 /sensorRequest  -  
 
 */

NetAddress myBroadcastLocation; 

void setupServer() {
  oscP5 = new OscP5(this, 12000);
}

void broadcast() {
  OscMessage  m = new OscMessage("/broadcast", new Object[]{"Hello"});
  oscP5.send(m, myNetAddressList);
}

void oscEvent(OscMessage msg) {
  /* get and print the address pattern and the typetag of the received OscMessage */
  if (msg.addrPattern().equals("/connect")) {
    println(msg.netAddress());
    connect(msg.netAddress().address());
  }
  else {
    println("### received an osc message with addrpattern "+msg.addrPattern()+" and typetag "+msg.typetag());
  }
  //  msg.print();
}

private void connect(String theIPaddress) {
  if (!myNetAddressList.contains(theIPaddress, broadcastPort)) {
    myNetAddressList.add(new NetAddress(theIPaddress, broadcastPort));
    println("### adding "+theIPaddress+" to the list.");
  } 
  else {
    println("### "+theIPaddress+" is already connected.");
  }
  println("### currently there are "+myNetAddressList.list().size()+" remote locations connected.");
}



private void disconnect(String theIPaddress) {
  if (myNetAddressList.contains(theIPaddress, broadcastPort)) {
    myNetAddressList.remove(theIPaddress, broadcastPort);
    println("### removing "+theIPaddress+" from the list.");
  } 
  else {
    println("### "+theIPaddress+" is not connected.");
  }
  println("### currently there are "+myNetAddressList.list().size());
}

