size(800, 600);
background(255);
strokeWeight(0.5);
smooth();

float radius = 100;
int centX = width/2;
int centY = height/2;

stroke(0, 30);
noFill();
ellipse(centX, centY, radius*2, radius*2);

stroke(20, 50, 70);
float x, y;
for(int i=0; i<100; i++) {

  float lastX = -999;
  float lastY = -999;
  float radiusNoise = random(10);
  radius = 10;
  for(float ang=0; ang<=360*8; ang+=1) {
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
