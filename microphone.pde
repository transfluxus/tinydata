import ddf.minim.*;

class Microphone extends SensorReading {
  
  Minim minim;
  AudioInput in;

  float amplitude;
  
  public Microphone() {
    super("microphone");
  }
  
  void init() {
    minim = new Minim(this);
    minim.debugOn();
    in = minim.getLineIn(Minim.MONO, 512);
    
    amplitude = 0.0f;
  }

  void execute() {
    println(name + " execute");
    
    amplitude = pickFromBuffer();
    readingDone = true;
    send();
  }
  
  float pickFromBuffer() {
    
    float amplitude = in.left.get(0); 
    
    for(int i = 0; i < in.bufferSize() - 1; i++) {
      //amplitude += in.left.get(i);
      println("       -  " + in.left.get(i));
    }
    //amplitude /= in.bufferSize();
    
    println("       -  " + amplitude + " @ " + in.bufferSize());
    
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

