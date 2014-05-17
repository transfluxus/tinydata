import lmu.*;

class AmbienceLight extends SensorReading {
  
  int lmu_left;
  int lmu_right;
  float multi;

  float brightness;
  
  public AmbienceLight() {
    super("ambienceLight");
  }
  
  void init() {
    
    // initial sensor values
    int[] lmu_start = LmuTracker.getLMUArray();
    lmu_left  = lmu_start[0];
    lmu_right = lmu_start[1];
    multi = 255.0 / (lmu_left);
    
    brightness = 0.0f;
  }

  void execute() {
    
    println(name + " executing");
    
    // get current sensor values
    int[] vals = LmuTracker.getLMUArray();
    int li = (int)(vals[0] * multi);
    int re = (int)(vals[1] * multi);
    
    println("li " + li);
    println("re " + re);
    println(" ");
    
    brightness = 1.0f;
  }
  
  void send() {
    OscMessage  m = new OscMessage("/data-" + name);
    
    m.add(brightness);
    
    oscP5.send(m, serverLocation);
  }

  void createFromMessage(OscMessage msg) {
      
  }
  
}
