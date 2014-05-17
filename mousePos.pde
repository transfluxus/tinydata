//Reads mouse position using robot, then puts it in Point "p"

void mousePos(){
Point p = getGlobalMouseLocation();
}

Point getGlobalMouseLocation() {
  PointerInfo pointerInfo = MouseInfo.getPointerInfo();
  Point p = pointerInfo.getLocation();
  return p;  
}
