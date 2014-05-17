import java.text.NumberFormat;


class Space extends SensorReading {

  // final values 
  float total, free;

    private Runtime runtime = Runtime.getRuntime();


    public Space() {
      super("space");
    }

    void init() {
    }

    void execute() {
      File[] roots = File.listRoots();

      /* For each filesystem root, print some info */
      for (File root : roots) {
        float gb = 1f/(1024*1024*1024);
        total = root.getTotalSpace()*gb;
        free = root.getFreeSpace()*gb;
      }
      send();
    }

    OscMessage createMessage(String adrPattern) {
      OscMessage  m = new OscMessage(adrPattern);
      m.add(name);
      m.add(total);
      m.add(free);
      return m;
    }

    void send() {
      OscMessage  m = createMessage("/data");
      oscP5.send(m, serverLocation);
      // this is important
      readingDone = true;
    }

    SensorReading createFromMessage(OscMessage msg) {
      Space sr = new Space();
      sr.total = msg.get(1).floatValue();
      sr.free = msg.get(2).floatValue();
      return sr;
    }

    void print() {
      println(name + " total space: "+total+" free space: "+free);
    }
  }

