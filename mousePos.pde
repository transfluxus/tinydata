//Reads mouse position using robot, then puts it in Point "p"
class MousePos extends SensorReading {

  //Mouse tracking:

  Robot robot;

  // temp stuff
  // final values 
  int x, y;


  public MousePos() {
    super("mousePos");
  }

  void init() {
    //Mouse tracking:
    try { 
      robot = new Robot();
      robot.setAutoDelay(0);
    } 
    catch (Exception e) {
      e.printStackTrace();
    }
  }

  void execute() {
    println(name + " execute");
    
    PointerInfo pointerInfo = MouseInfo.getPointerInfo();
    Point p = pointerInfo.getLocation();
    x = p.x;
    y = p.y;
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
    OscMessage  m = createMessage("/data");
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
    println(name + " x: "+x+" y: "+y);
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

