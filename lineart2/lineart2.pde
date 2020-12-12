//ArrayList<PVector> prevPoints;
ArrayList<PVector> points;
PGraphics big;
int w = 500;
int h = 3000;
float res = 0.3;
int hd = 3;
int wd = 2;
int margin = 100;
int spd = 10;
float xoff = 0;
float noiseRange = 10;
int rmax = 0;
int rmin = 0;
int hmin = 0;
color bg = color(82,1,32);
color lineColor = color(242,197,61, 80);
int seed = parseInt(String.valueOf(floor(random(1000000,10000000))).substring(1));
boolean saving = false;

void settings(){
  size(floor(w * res), floor(h * res));
  smooth(8);
}

void setup() {
  big = createGraphics(w,h);
  println(seed);
  noiseSeed(seed);
  randomSeed(seed);
	points = new ArrayList<PVector>();
}

void draw() {
	if (points.size() == 0) {
    big.beginDraw();
  	big.background(bg);
    big.endDraw();
  	for (int i = 0; i < h / hd; i++) {
  	  PVector point = getNewPoint(3,i);
  	  xoff +=0.01;
  	  points.add(point);
  	  if (point.x > rmax) {rmax = constrain(ceil(point.x), 0, w-1);}
  	}
	}
	else{
  	big.loadPixels();
  	points = new ArrayList<PVector>();
  	int locRmin = w;
    int locHmin = 0;
  	for (int i = 0; i < h / hd; i++) {
  	  int y = i * hd;
  	  int x = rmax;
  	  while(big.pixels[y * w + x] == color(bg)) {
  	    x--; //<>//
  	  }
      PVector point;
      if (floor(x) >= w-1){
  	    point = getNewPoint(i);
        //stroke(255,0,0);
        //fill(255,0,0);
        //line(points.get(points.size()).x,points.get(points.size()).y,point.x, point.y);
        //ellipse(points.get(points.size()).x-1,points.get(points.size()).y-1,1,1);
        println("out");
      }else {
  	    point = getNewPoint(0,i,x);
      }
  	  points.add(point);
  	  if (point.x > rmax) {
    	  rmax = constrain(ceil(point.x), 0, w-1);
    	}
  	  if (point.x < locRmin) {
        locRmin = ceil(point.x);
        locHmin = floor(point.y);
      }
  	  xoff +=0.01;
  	}
  	if (locRmin > rmin) {
  	  rmin = locRmin;
      hmin = locHmin;
  	}
  	//updatePixels();
	}
  big.beginDraw();
	big.noFill();
	big.stroke(lineColor);
	big.strokeWeight(0.5);
  //big.translate(margin, margin);
	big.beginShape();
	for (int i = 0; i < points.size(); i++) {
	  big.vertex(points.get(i).x, points.get(i).y);
	}
	big.endShape();
  big.noStroke();
  big.fill(bg);
  big.rect(w,0,margin, h);
  big.endDraw();
  
  //background(bg);
  image(big, 0, 0, width, height);

  //fill(255,0,0);
  //ellipse(rmin, hmin, 2, 2);
	if (rmin >= w) {
    println("Done Generating");
    if(saving){
      println("saving...");
      String picName = "pictures//line_" + seed + ".png";
      PGraphics art = createGraphics(w,h);
      art.beginDraw();
      art.background(bg);
      art.image(big, margin, margin, w - 2*margin, h - 2*margin);
      art.save(picName);
      println("picture saved as:", picName);
    }
	  noLoop(); //<>//
	}
	 //noLoop();
	//println(rmax);
}

PVector getNewPoint(int y){
  return new PVector(w+5, y * hd);
}

PVector getNewPoint(int x, int y) {
	float xpos = x * (wd + 1) + (map(noise(xoff),0,1, - noiseRange,noiseRange));
	PVector v = new PVector(xpos,y * (hd));
	return v;
}

PVector getNewPoint(int x, int y, float prevx) {
	float xpos = prevx + wd + (map(noise(xoff),0,1, - noiseRange,noiseRange));
	PVector v = new PVector(xpos,y * (hd));
	return v;
}
