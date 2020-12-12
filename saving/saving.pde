int pointNum = 50;
int imgNum = 10;
PShape s;

void setup(){
  size(500,500);
  background(255);
  noFill();
  noLoop();
}

void draw(){
  for (int n = 0; n < imgNum; n++){
    background(255);
    s = createShape();
    s.beginShape();
    s.stroke(126,0,0);
    //s.fill(50);
    for (int i = 0; i < pointNum; i++){
      s.vertex(random(width), random(height));
    }
    s.endShape(CLOSE);
    shape(s, 0,0);
    save("pictures_tiff/lines_" + n + ".tiff");
  }
}
