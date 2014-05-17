class Microphone extends SensorReading {
  
  float amplitude;
  
  public Microphone() {
    super("microphone");
  }
  
  void init() {
    amplitude = 0.0f;
  }

  void execute() {
    amplitude = 1.0f;
  }
  
  void send() {
    println(name + " send");
    
    OscMessage  m = new OscMessage("/data-" + name);
    m.add(amplitude);
    oscP5.send(m, serverLocation);
  }
  
  SensorReading createFromMessage(OscMessage msg) {
    Microphone microphone = new Microphone();
    microphone.amplitude = msg.get(1).floatValue();
    return microphone;
  }
  
  OscMessage createMessage(String adrPattern) {
    OscMessage  m = new OscMessage(adrPattern);
    m.add(name);
    m.add(amplitude);
    return m;
  }
  
  void print() {
    println("amplitude: " + amplitude);
  }
}

