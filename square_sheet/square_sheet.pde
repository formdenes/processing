final int SMALLSTEP = 20;
final int STEP = 100;
final int w = 1000;
final int h = 1000;


final color bg = color(240);
final boolean saving = false;
final int picNum = 1;


PGraphics pg;
ArrayList<Line> lines;
// PImage distMap;
Interpolant interpolant;
color[] colors;
color randomColor;
// ArrayList<Node> nodes;
int counter = 0;
String seed = "0";
float margin = 100;
// float amp;
// float xoff = 0;
// float yoff = 0;
// float inc = 1;

void settings(){
  float res = min(displayWidth / (float) w, displayHeight / (float) h * 9 / 10);
  size(floor(w * res), floor(h * res), P2D);
}

void setup(){
  // distMap = loadImage("texture.jpg");
  margin = w/12;
  // amp = SMALLSTEP / 10 * 20;
  seed = setSeed();
  // seed = setSeed("303524");
  pg = createGraphics(w, h, P2D);
  pg.smooth(8);
  // nodes = new ArrayList<Node>();
  randomColor = color(random(255), random(255), random(255));
  colors = getNiceColors(randomColor);
  interpolant = new Interpolant((float) h, colors, false);
}

void draw(){
  setup();
  pg.beginDraw();
  pg.background(255);
  lines = new ArrayList<Line>();
  for(int j = 0; j < w / STEP; j++){
    for(int i = 0; i < h / STEP; i++){
      ArrayList<PVector> points = new ArrayList<PVector>();
      int x = j * STEP;
      int xx = (j + 1) * STEP;
      int y = i * STEP;
      int yy = (i + 1) * STEP;
      // pg.noFill();
      // pg.stroke(0);
      // pg.rect(x, y, xx, yy);
      points.add(new PVector(x, y + SMALLSTEP));
      for(int n = 0; n < STEP/SMALLSTEP; n++){
        points.add(new PVector(x + n * SMALLSTEP, y));
        points.add(new PVector(x, y + (n+1) * SMALLSTEP));
      }
      for(int n = 0; n < STEP/SMALLSTEP; n++){
        points.add(new PVector(x + n * SMALLSTEP, yy));
        points.add(new PVector(xx, y + n * SMALLSTEP));
      }
      Line line = new Line(points, color(0), 2, pg);
      lines.add(line);
    }
  }
  for(Line line : lines){
    line.handLineWidth();
  }
  pg.endDraw();
  image(pg, 0, 0, width, height);
  if(saving){ 
    save("maze_" + seed, plotArt(pg, bg, margin, w, h), w, h); 
    if(counter < picNum - 1){ 
      counter++; 
    } else {
      println("END");
      noLoop();
      exit();
    }
  }
  else{
    noLoop();
  }
}