abstract class SensorReading {

  final String name; 

  boolean done = false;

  public SensorReading(String name) {
    this.name = name;
  }

  abstract void init();

  abstract void execute();

  abstract OscMessage createMessage(String adrPattern);

  abstract void send();

  abstract SensorReading createFromMessage(OscMessage msg);

  abstract void print();

  // this was for averaging, but its out
  //  abstract SensorReading createFromList(ArrayList<SensorReading> list);
}


