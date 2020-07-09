float centX, centY;

void setup() {
  size(800, 400);
  smooth();
  background(255);
  stroke(20, 50, 70, 10);
  strokeWeight(5);
  centX = width/2;
  centY = height/2;
}

void draw() {
  //上辺
  for(int i = 20; i <= 80; i++) {
    float randX = random(width);
    float randY = random(height);
    line(i, centY+30, randX, randY);
  }
  
  //右辺
  for(int i = -30; i <= 30; i++) {
    float randX = random(width);
    float randY = random(height);
    line(80, centY+i, randX, randY);
  }
  
  //下辺
  for(int i = 80; i >= 20; i--) {
    float randX = random(width);
    float randY = random(height);
    line(i, centY-30, randX, randY);
  }
  
  //左辺
  for(int i = -30; i >= 30; i--) {
    float randX = random(width);
    float randY = random(height);
    line(i, centY+i, randX, randY);
  }
}
