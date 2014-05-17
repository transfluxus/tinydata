abstract class SensorReading {

  final String name; 


  public SensorReading(String name) {
    this.name = name;
  }

  // init is called when the request comes in
  abstract void init();

  // is called in the client.update
  abstract void execute();

  // is called by send
  abstract OscMessage createMessage(String adrPattern);

  // should be called in execute
  abstract void send();

  // created by server, when data comes in and by client when results come in
  abstract SensorReading createFromMessage(OscMessage msg);

  // print results
  abstract void print();

  // this was for averaging, but its out
  //  abstract SensorReading createFromList(ArrayList<SensorReading> list);
}

