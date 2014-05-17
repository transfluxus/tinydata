import ddf.minim.*;

class Microphone extends SensorReading {
  
  Minim minim;
  AudioInput microphone;

  float amplitude;
  
  public Microphone() {
    super("microphone");
  }
  
  void init() {
    amplitude = 0.0f;
  }

  void execute() {
    println(name + " execute");
    
    amplitude = pickFromBuffer();
    readingDone = true;
    send();
  }
  
  float pickFromBuffer() {
    float amplitude =  0.0f;
    
    minim = new Minim(this);
    microphone = minim.getLineIn (Minim.STEREO, 512);
    
    if (microphone != null) {
      amplitude = microphone.mix.level(); 
      microphone.close();
    } else {
      println("Error: no lin-in present: ");
    }
    minim.stop();
    
    println("       -  " + amplitude);
    return amplitude;
  }
    
  void send() {
    OscMessage m = createMessage("/data");
    oscP5.send(m, serverLocation);
  }
  
  SensorReading createFromMessage(OscMessage msg) {
    Microphone microphone = new Microphone();
    microphone.amplitude = msg.get(1).floatValue();
    return microphone;
  }
  
  OscMessage createMessage(String adrPattern) {
    OscMessage m = new OscMessage(adrPattern);
    m.add(name);
    m.add(amplitude);
    return m;
  }
  
  void print() {
    println(name + " amplitude: " + amplitude);
  }
}

