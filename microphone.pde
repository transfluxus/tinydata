class Microphone extends SensorReading {
  
  AudioInput microphoneInput;
  float amplitude;
  
  public Microphone(AudioInput micro) {
    super("microphone");
    microphoneInput = micro;
  }
  
  void init() {
    amplitude = 0.0f;
  }

  void execute() {
    amplitude = getAmplitude();
    readingDone = true;
    send();
  } 
  
  void send() {
    OscMessage m = createMessage("/data");
    oscP5.send(m, serverLocation);
  }
  
  SensorReading createFromMessage(OscMessage msg) {
    Microphone microphone = new Microphone(microphoneInput);
    microphone.amplitude = msg.get(1).floatValue();
    return microphone;
  }
  
  OscMessage createMessage(String adrPattern) {
    OscMessage m = new OscMessage(adrPattern);
    m.add(name);
    m.add(amplitude);
    return m;
  }
  
  float getAmplitude() {
    float amplitude =  0.0f;
    if (microphoneInput != null) {
      amplitude = microphoneInput.mix.level(); 
    } else {
      println("Error: no lin-in present: ");
    }
    println("       -  " + amplitude);
    return amplitude;
  }
  
  void print() {
    println(name + " amplitude: " + amplitude);
  }
}

