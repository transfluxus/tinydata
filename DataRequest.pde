abstract class SensorReading {

  final String name; 

  public SensorReading(String name) {
    this.name = name;
  }

  abstract void init();

  abstract void execute();

  abstract void send();

  abstract void createFromMessage(OscMessage msg);
}

class MousePos extends SensorReading {

  // temp stuff
  // final values 
  int x, y;


  public MousePos() {
    super("mousePos");
  }

  void init() {
  }

  void execute() {
    x = mouseX;
    y = mouseY;
  }

  void send() {
    OscMessage  m = new OscMessage("/data-"+name);
    m.add(x);
    m.add(y);
    oscP5.send(m, serverLocation);
  }

  void createFromMessage(OscMessage msg) {
  }
}

