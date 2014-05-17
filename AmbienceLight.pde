/*
import lmu.*;

class AmbienceLight extends SensorReading {
  
  int lmu_left;
  int lmu_right;
  float multi;

  float brightness;
  
  public AmbienceLight() {
    super("ambienceLight");
    
    println(name + " created");
  }
  
  void init() {
    
    println(name + " init");
    
    int[] lmu_start = LmuTracker.getLMUArray();
    lmu_left  = lmu_start[0];
    lmu_right = lmu_start[1];
    multi = 255.0 / (lmu_left);
    
    brightness = 0.0f;
  }

  void execute() {
    
    println(name + " executing");
    
    int[] vals = LmuTracker.getLMUArray();
    int li = (int)(vals[0] * multi);
    int re = (int)(vals[1] * multi);
    
    println("li " + li);
    println("re " + re);
    println(" ");
    
    brightness = 1.0f;
    send();
  }
  
  void send() {
    println(name + " send");
    
    OscMessage  m = new OscMessage("/data-" + name);
    m.add(brightness);
    oscP5.send(m, serverLocation);
  }

  SensorReading createFromMessage(OscMessage msg) {
    AmbienceLight ambiencelight = new AmbienceLight();
    ambiencelight.brightness = msg.get(1).floatValue();
    return ambiencelight;
  }
  
  OscMessage createMessage(String adrPattern) {
    OscMessage  m = new OscMessage(adrPattern);
    m.add(name);
    m.add(brightness);
    return m;
  }
  
  void print() {
    println("ambience print()");
  }
  
}

*/
