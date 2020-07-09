
void setup() {
  size(800, 600);
  background(255);
  strokeWeight(0.5);
  smooth();
  
  // 目
  float radius = 100;
  int centX = width/2;
  int centY = height/2 + 20;
  
  stroke(20, 50, 70);
  float x, y;
  for(int i=0; i<100; i++) {
    float lastX = -999;
    float lastY = -999;
    float radiusNoise = random(10);
    radius = 10;
    stroke(random(20), random(50), random(70), 80);
    for(float ang=0; ang<=360*random(3.0, 3.2); ang+=1) {
      radiusNoise += 0.05;
      radius += 0.2;
      float thisRadius = radius + (noise(radiusNoise) * 200) - 100;
      float rad = radians(ang);
      x = centX + (thisRadius * cos(rad));
      y = centY + (thisRadius * sin(rad));
      if(lastX > -999) {
        line(x, y, lastX, lastY);
      }
      lastX = x;
      lastY = y;
    }
  }
  
  
  stroke(0);
  strokeWeight(5);
  
  // 上瞼
  y = 0;
  int step = 10;
  float lastX = -999;
  float lastY = -999;
  float angle = 0;
  for(x=20; x<=width-20; x+=step) {
    float rad = radians(angle);
    y = height/2 +  sin(rad) * 150;
    if(lastX > -999) {
      line(x, y, lastX, lastY);
    }
    lastX = x;
    lastY = y;
    angle += 2.37;
  }
  
  // 下瞼
  y = 0;
  lastX = -999;
  lastY = -999;
  angle = 180;
  for(x=20; x<=width-20; x+=step) {
    float rad = radians(angle);
    y = height/2 +  sin(rad) * 150;
    if(lastX > -999) {
      line(x, y, lastX, lastY);
    }
    lastX = x;
    lastY = y;
    angle += 2.37;
  }
}

void draw() {
}

void keyPressed(){
  if(keyCode == ENTER) {
    save("perline_2d_4.png");
    print("保存完了!");
  }
}
