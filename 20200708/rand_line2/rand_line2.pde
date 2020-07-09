int centX, centY;

void setup() {
  size(800, 400);
  smooth();
  background(255);
  stroke(20, 50, 70);
  strokeWeight(5);
  centX = width/2;
  centY = height/2;
  line(centX-200, centY, centX+200, centY);
  
  
  stroke(#FFFC00);
  strokeWeight(10);
  int step = 10;
  float lastX = -999;
  float lastY = 999;
  float y = 50;
  int borderX = 180;
  int borderY = centY + 50;
  for (int x=centX-borderX; x<=centX+borderX; x+=step) {
    y = borderY + random(height - 2*borderY);
    if (lastX > -999 && x!=centX-borderX) {
      line(x, y, lastX, lastY);
    }
    lastX = x;
    lastY = y;
  }
}

void draw() {
  
}
