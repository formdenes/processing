// array of PVectors, one for each vertex in the polygon
PVector[] vertices = new PVector[8];
float z = 1;
float f = 1.01;
float w,h;

PVector o = new PVector(5,9);

void setup() {
  size(500,300);
  
  vertices[0] = new PVector(5,0);
  vertices[1] = new PVector(9,4);
  vertices[2] = new PVector(9,7);
  vertices[3] = new PVector(8,8);
  
  vertices[4] = new PVector(5,9);
  vertices[5] = new PVector(2,8);
  vertices[6] = new PVector(1,7);
  vertices[7] = new PVector(1,4);
  
}


void draw() {
  background(255);

  fill(0,150,255);

  // draw the polygon using beginShape()

  noStroke();
  translate(width / 10 * o.x - (o.x * z), height / 10 * o.y - (o.y * z));
  beginShape();
  for (PVector v : vertices) {
    vertex(v.x * z, v.y * z);
  }
  endShape();
  //translate(-(width / 2 - w * z), 0);
  z =  constrain(z * f,1, min(width / 10, height / 10));
}
