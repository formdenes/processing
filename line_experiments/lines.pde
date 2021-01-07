class Line{
  float seed;
  ArrayList<PVector> points;
  color col;
  PGraphics pg;
  float size;

  Line(float x, float y, float xx, float yy, color col, float s, PGraphics g){
    this.col = col;
    this.size = s;
    this.pg = g;
    seed = random(999999);
    points = new ArrayList<PVector>();
    points.add(new PVector(x,y));
    points.add(new PVector(xx,yy));
  }

  Line(ArrayList<PVector> points, color col, float s, PGraphics g){
    this.points = points;
    this.col = col;
    this.size = s;
    this.pg = g;
    seed = random(999999);
  }

  void betterLine(){
    betterLine(6);
  }

  void betterLine(int rep){
    for(int p = 0; p < points.size() - 1; p++){
      float x = points.get(p).x;
      float y = points.get(p).y;
      float xx = points.get(p + 1).x;
      float yy = points.get(p + 1).y;
      pg.noFill();
      pg.strokeCap(ROUND);
      pg.stroke(col);
      pg.strokeWeight(size);
      pg.line(x, y, xx, yy);
      pg.stroke(col, 10);
      for(int n = 0; n < rep; n++){
        pg.strokeWeight(size*pow(1.1, n));
        pg.line(x, y, xx, yy);
      }
    }
  }

  void handLine(){
    handLine(6);
  }

  void handLine(int rep){
    for(int p = 0; p < points.size() - 1; p++){
      float x = points.get(p).x;
      float y = points.get(p).y;
      float xx = points.get(p + 1).x;
      float yy = points.get(p + 1).y;
      float dens = 10;
      float _dist = dist(x,y,xx,yy);
      int maxi = floor(_dist / dens);
      float xstep = (xx - x) / maxi;
      float ystep = (yy - y) / maxi;
      float xoff = seed;
      float ampl = size * 3;
      PVector normal = new PVector(xx - x, yy - y);
      normal.normalize();
      normal.x = normal.x + normal.y;
      normal.y = normal.x - normal.y;
      normal.x = normal.x - normal.y;
      pg.fill(col);
      pg.stroke(col);
      pg.strokeWeight(size);
      pg.noFill();
      pg.beginShape();
      pg.curveVertex(x, y);
      for(int i = 0; i < maxi + 1; i++){
        normal.mult(noise(xoff) * ampl);
        float _x = x + xstep * i + normal.x;
        float _y = y + ystep*i + normal.y;
        pg.curveVertex(_x, _y); //<>//
        normal.normalize();
        xoff += .1;
      }
      pg.curveVertex(xx, yy);
      pg.endShape();
    }
  }

  void handLineWidth(){
    handLineWidth(6);
  }

  void handLineWidth(int rep){
    for(int p = 0; p < points.size() - 1; p++){
      float x = points.get(p).x;
      float y = points.get(p).y;
      float xx = points.get(p + 1).x;
      float yy = points.get(p + 1).y;
      float dens = 10;
      float _dist = dist(x,y,xx,yy);
      int maxi = floor(_dist / dens);
      float xstep = (xx - x) / maxi;
      float ystep = (yy - y) / maxi;
      float xoff = seed;
      float ampl = size * 3;
      float xoff2 = seed + 99999;
      float ampl2 = size * 1.5;
      PVector normal = new PVector(xx - x, yy - y);
      normal.normalize();
      normal.x = normal.x + normal.y;
      normal.y = normal.x - normal.y;
      normal.x = normal.x - normal.y;
      pg.fill(col);
      pg.stroke(col);
      pg.strokeWeight(size);
      pg.noFill();
      pg.beginShape();
      pg.curveVertex(x, y);
      for(int i = 0; i < maxi + 1; i++){
        normal.mult(noise(xoff) * ampl);
        float _x = x + xstep * i + normal.x;
        float _y = y + ystep*i + normal.y;
        pg.strokeWeight(ampl2 * noise(xoff2));
        pg.curveVertex(_x, _y); //<>//
        normal.normalize();
        xoff += .1;
        xoff2 += .05;
      }
      pg.curveVertex(xx, yy);
      pg.endShape();
    }
  }

}