int diam = 10;
float centX, centY;
boolean is_small = true;

void setup() {
  size(800, 400);
  //frameRate(24);
  smooth();
  background(0);
  centX = width / 2;
  centY = height / 2;
  stroke(0);
  strokeWeight(1);
}

void draw() {
  if(is_small) {
    fill(255, 25);
    ellipse(mouseX, mouseY, diam, diam);
    diam += 10;
  } else {
    fill(0, 25);
    ellipse(mouseX, mouseY, diam, diam);
    diam -= 10;
  }
  if (diam <= 50) {
    is_small = true;
  } else if (diam > 200) {
    is_small = false;
  }
}
