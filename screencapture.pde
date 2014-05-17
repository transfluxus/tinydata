//import java.awt.image.BufferedImage;
//import java.awt.*;
//public Robot robot;
//
//PImage img;
// 
//int r, g, b;
//color average;
//
//void setup()
//{
// colorMode(RGB,255);
//
// loadPixels();
//
// size(500,500);    //OPENGL does not display correctly
//
//   try {
//    robot = new Robot();
//    BufferedImage bufferedImage = robot.createScreenCapture(
//    new Rectangle(new Dimension(displayWidth, displayHeight)));
//      
//    img   = new PImage(bufferedImage);
//  }
//  catch (AWTException e) {
//      e.printStackTrace();
//  }
//
//}
// 
//void draw(){
//  BufferedImage bufferedImage = robot.createScreenCapture(
//new Rectangle(new Dimension(displayWidth, displayHeight)));
//  
//img   = new PImage(bufferedImage);
// image(img,0,0);
// 
//       for (int i = 0; i < img.pixels.length; i++) {
//    r+= red(img.pixels[i]);
//    g+= green(img.pixels[i]);
//    b+= blue(img.pixels[i]);
//  }
//  r= r/img.pixels.length;
//  g= g/img.pixels.length;
//  b= b/img.pixels.length;
//
//  average = color(r,g,b);
//  
//    fill(average);
//  rect(0,0,100,100); 
//}

