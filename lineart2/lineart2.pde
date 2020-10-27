//ArrayList<PVector> prevPoints;
ArrayList<PVector> points;
PGraphics big;
int w = 2000;
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
color bg = color(255);
color lineColor = color(22, 50);
int seed = parseInt(String.valueOf(floor(random(1000000,10000000))).substring(1));

//void setting(){}

void setup() {
	size(1000, 1000);
	//prevPoints = new ArrayList<PVector>();
	//println(points);
	points = new ArrayList<PVector>();
	//println(points);
}

void draw() {
	//prevPoints = points;
	if (points.size() == 0) {
  	//println("firstrun");
  	background(bg);
  	for (int i = 0; i < height / hd; i++) {
  	  PVector point = getNewPoint(3,i);
  	  xoff +=0.01;
  	  points.add(point);
  	  if (point.x > rmax) {rmax = constrain(ceil(point.x), 0, width);}
  	}
	}
	else{
  	//println("nexRuns");
  	loadPixels();
  	points = new ArrayList<PVector>();
  	int locRmin = width;
    int locHmin = 0;
  	for (int i = 0; i < height / hd; i++) {
  	  int y = i * hd;
  	  int x = rmax;
  	  while(pixels[y * width + x] == color(bg)) {
  	    x--;
  	  }
      PVector point;
      if (floor(x) >= width){
  	    point = getNewPoint(i);
        //stroke(255,0,0);
        fill(255,0,0);
        //line(points.get(points.size()).x,points.get(points.size()).y,point.x, point.y);
        //ellipse(points.get(points.size()).x-1,points.get(points.size()).y-1,1,1);
        println("out");
      }else {
  	    point = getNewPoint(0,i,x);
      }
  	  points.add(point);
  	  if (point.x > rmax) {
    	  rmax = constrain(ceil(point.x), 0, width-1);
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
	noFill();
	stroke(lineColor);
	strokeWeight(0.5);
	beginShape();
	for (int i = 0; i < points.size(); i++) {
	vertex(points.get(i).x, points.get(i).y);
	}
	endShape();

  //fill(255,0,0);
  //ellipse(rmin, hmin, 2, 2);
	if (rmin >= width) {
    println("done");
	  noLoop(); //<>//
	}
	 //noLoop();
	//println(rmax);
}

PVector getNewPoint(int y){
  return new PVector(width, y * hd);
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
