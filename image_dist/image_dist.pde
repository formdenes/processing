PImage im;
PGraphics pg;
ArrayList<PVector> vectors;
ArrayList<PVector> points;
int STEP = 10;

void setup(){
  size(1600, 800);
  colorMode(HSB, 255);
  im = loadImage("./texture.jpg");
  im.resize(width / 2, height);
  im.filter(GRAY);
  pg = createGraphics(width / 2, height);
  pg.colorMode(HSB, 255);
  vectors = new ArrayList<PVector>();
  points = new ArrayList<PVector>();
}

void draw(){
  pg.beginDraw();
  im.loadPixels();
  pg.loadPixels();
  try{
  for(int y = 0; y < height / STEP; y++){
    for(int x = 0; x < width / 2 / STEP; x++){
      PVector point = new PVector(x * STEP + (STEP / 2), y * STEP + (STEP / 2));
      PVector vect = new PVector(0,0);
      float b = 0;
      for(int yy = 0; yy < STEP; yy++){
        for(int xx = 0; xx < STEP; xx++){
          int _bright = im.pixels[x * STEP + xx + (y * STEP + yy) * im.width];
          b += brightness(_bright);
          PVector _v = new PVector(xx-(STEP / 2), yy-(STEP / 2));
          _v.setMag(map(255 - _bright, 0, 255, 0, STEP));
          // _v.normalize();
          vect.add(_v);
        }
      }
      b = b / (STEP * STEP);
      // vect.normalize().mult(map(b, 0, 255, 0, STEP));
      vect.setMag(map(255 - b, 0, 255, 0, STEP));
      vectors.add(vect);
      points.add(point.add(vect));
      for(int yy = 0; yy < STEP; yy++){
        for(int xx = 0; xx < STEP; xx++){
          pg.pixels[x * STEP + xx + (y * STEP + yy) * im.width] = color(b);
        } //<>//
      }
    }
  }
  } //<>// //<>//
  catch (Exception e) {
    println(e); //<>//
  }
  pg.updatePixels();
  for(int y = 0; y < height / STEP; y++){
    for(int x = 0; x < width / 2 / STEP; x++){
      PVector vect = vectors.get(x + (y * width / 2 / STEP));
      PVector point = points.get(x + (y * width / 2 / STEP));
      pg.colorMode(RGB);
      pg.noFill();
      pg.stroke(255, 0, 0);
      // pg.line(x * STEP + (STEP / 2), y * STEP + (STEP / 2), x * STEP + vect.x + (STEP / 2), y * STEP + vect.y + (STEP / 2));
      pg.noStroke();
      pg.fill(255,0,0);
      pg.circle(point.x, point.y, STEP / 10 * 2);
      pg.colorMode(HSB);
    }
  }
  pg.endDraw();
  image(im, 0, 0, width / 2, height);
  image(pg, width / 2, 0, width / 2, height);

  noLoop();
}
