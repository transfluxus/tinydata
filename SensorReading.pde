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

/*
class MousePos extends SensorReading {

  // temp stuff
  // final values 
  int x, y;


  public MousePos() {
    super("mousePos");
  }

  void init() {
    // damnit this must be in all sensors
    done = false;
    // nothing to do here
  }

  void execute() {
    x = mouseX;
    y = mouseY;
    // for test, just get the pos and send it
    send();
  }

  OscMessage createMessage(String adrPattern) {
    OscMessage  m = new OscMessage(adrPattern);
    m.add(name);
    m.add(x);
    m.add(y);
    return m;
  }

  void send() {
    OscMessage  m = createMessage("/dataSend");
    oscP5.send(m, serverLocation);
    // this is important
    readingDone = true;
  }

  SensorReading createFromMessage(OscMessage msg) {
    MousePos sr = new MousePos();
    sr.x = msg.get(1).intValue();
    sr.y = msg.get(2).intValue();
    return sr;
  }

  void print() {
    println("x: "+x+" y: "+y); 
  }

  // this was for averaging, but its out
  /*
  SensorReading createFromList( ArrayList<SensorReading> list) {
   MousePos sr = new MousePos();
   int sumX,sumY;
   for(SensorReading r : list) {
   MousePos mp =(MousePos) r;
   sumX += mp.x;
   sumY += mp.y;
   }
   sr.x = sumX / list.size();
   sr.y = sumY / list.size();
   return sr;
   }
   */
}
*/
