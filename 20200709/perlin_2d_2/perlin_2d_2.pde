size(500, 300);
background(255);
strokeWeight(0.5);
smooth();

float radius = 100;
int centX = 250;
int centY = 150;

stroke(0, 30);
noFill();
ellipse(centX, centY, radius*2, radius*2);

stroke(20, 50, 70);
float x, y;
float lastX = -999;
float lastY = -999;
float radiusNoise = random(10);
radius = 10;
for(float ang=0; ang<=360*10; ang+=1) {
  radiusNoise += 0.05;
  radius += 0.1;
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
