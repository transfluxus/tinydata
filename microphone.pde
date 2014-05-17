/*
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
    OscMessage  m = new OscMessage("/data-" + name);
    
    m.add(amplitude);
    
    oscP5.send(m, serverLocation);
  }

  void createFromMessage(OscMessage msg) {
      
  }
  
}
*/
