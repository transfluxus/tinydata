
class ScreenSize extends SensorReading {

  // temp stuff
  // final values 
  int width, height;


  public MousePos() {
    super("screenSize");
  }

  void init() {
  }

  void execute() {
    Dimension screenSize = Toolkit.getDefaultToolkit().getScreenSize();
    this.width = (int)screenSize.getWidth();
    this.height =(int) screenSize.getHeight();
    send();
  }

  OscMessage createMessage(String adrPattern) {
    OscMessage  m = new OscMessage(adrPattern);
    m.add(name);
    m.add(this.width);
    m.add(this.height);
    return m;
  }

  void send() {
    OscMessage  m = createMessage("/data");
    oscP5.send(m, serverLocation);
    // this is important
    readingDone = true;
  }

  SensorReading createFromMessage(OscMessage msg) {
    ScreenSize sr = new ScreenSize();
    sr.width = msg.get(1).intValue();
    sr.height = msg.get(2).intValue();
    return sr;
  }

  void print() {
    println(name + " width: "+x+" height: "+y);
  }
}

