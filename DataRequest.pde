abstract class SensorReading {

  final String name; 

  public SensorReading(String name) {
    this.name = name;
  }

  abstract void execute();

  abstract void send();
}

class MousePos extends SensorReading {

  int x, y;

  public MousePos() {
    super("mousePos");
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
}

