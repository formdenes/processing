void betterLine(float x, float y, float xx, float yy, color col, float s, PGraphics g){
  betterLine(x, y, xx, yy, col, s, g, 6);
}

void betterLine(float x, float y, float xx, float yy, color col, float s, PGraphics g, int rep){
  g.noFill();
  g.strokeCap(ROUND);
  g.stroke(col);
  g.strokeWeight(s);
  g.line(x, y, xx, yy);
  g.stroke(col, 10);
  for(int n = 0; n < rep; n++){
    g.strokeWeight(s*pow(1.1, n));
    g.line(x, y, xx, yy);
  }
}

void handLine(float x, float y, float xx, float yy, color col, float s, PGraphics g){
  handLine(x, y, xx, yy, col, s, g, 6);
}

void handLine(float x, float y, float xx, float yy, color col, float s, PGraphics g, int rep){
  float dens = 10;
  float _dist = dist(x,y,xx,yy);
  int maxi = floor(_dist / dens);
  float xstep = (xx - x) / maxi;
  float ystep = (yy - y) / maxi;
  g.fill(col);
  g.stroke(col);
  g.strokeWeight(s);
  g.noFill();
  g.beginShape();
  for(int i = 0; i < maxi + 1; i++){
    float _x = x + xstep * i;
    float _y = y + ystep*i;
    vertex(_x, _y);
  }
  g.endShape();
  // g.line(x, y, xx, yy);
  // g.stroke(col, 10);
  // for(int n = 0; n < rep; n++){
  //   g.strokeWeight(s*pow(1.1, n));
  //   g.line(x, y, xx, yy);
  // }
}
void handLine(float x, float y, float xx, float yy, color col, float s){
  float dens = 10;
  float _dist = dist(x,y,xx,yy);
  int maxi = floor(_dist / dens);
  float xstep = (xx - x) / maxi;
  float ystep = (yy - y) / maxi;
  float xoff = 0.0;
  float ampl = s * 3;
  PVector normal = new PVector(xx - x, yy - y);
  normal.normalize();
  normal.x = normal.x + normal.y;
  normal.y = normal.x - normal.y;
  normal.x = normal.x - normal.y;
  fill(col);
  stroke(col);
  strokeWeight(s);
  noFill();
  beginShape();
  curveVertex(x, y);
  for(int i = 0; i < maxi + 1; i++){
    normal.mult(noise(xoff) * ampl);
    float _x = x + xstep * i + normal.x;
    float _y = y + ystep*i + normal.y;
    curveVertex(_x, _y); //<>//
    normal.normalize();
    xoff += .1;
  }
  curveVertex(xx, yy);
  endShape();
}
