boolean save = true;
boolean saveFrame = true;
boolean randomColor = true;
boolean colorRamp = true;

int maxPic = 5;
int picCount = 0;

ArrayList<PVector> walkers;
PGraphics movingG;
PGraphics big; 
int w = 3000;
int h = 3000;
float res = 0.2;
int iterations = 100;
float density = 0.05;
int maxRadius = 30;
int maxWalkers = floor(maxRadius * maxRadius * density);
int hardcap = 50000;
float stickieness = 0.1;
int feather = 20;
float saveTreshold = 1.01;
int prevWalkerCount = 0;
int curWalkerCount = 0;

int margin = 50;

float radius = 3;
color bg = color(82,1,32);
color movingColor = color(255, 0, 0);
color stuckColor = color(242,197,61, 80);
color rampBg = color(25);
//color[] colorPoints = {color(2,0,13), color(217,4,142), color(103,8,166), color(188,4,191), color(217,4,142), color(89,2,43)};
// color[] colorPoints = {color(13, 0, 0), color(24, 18, 64), color(73, 55, 140), color(88, 51, 166), color(108, 48, 191)};
color[] colorPoints = {color(118, 114, 242), color(133, 139, 242), color(136, 162, 242), color(114, 182, 242), color(145, 205, 242)};
Interpolant WikiInterpolant;

boolean done = false;
int seed = parseInt(String.valueOf(floor(random(1000000,10000000))).substring(1));

void settings() {
	size(floor(w * res),floor(h * res), P2D);
	smooth(8);
}

void setup() {
	noiseSeed(seed);
	randomSeed(seed);
	big = createGraphics(w,h, P2D);
	movingG = createGraphics(w,h);
	walkers = new ArrayList<PVector>();
	if (randomColor) {
		bg = color(noise(random(seed)) * 255, noise(random(seed)) * 255, noise(random(seed)) * 255);
		stuckColor = color(noise(random(seed)) * 255, noise(random(seed)) * 255, noise(random(seed)) * 255, 80);
	}
  WikiInterpolant = new Interpolant((float) sqrt(w / 2 * w / 2), colorPoints, false);
  prevWalkerCount = walkers.size();
  curWalkerCount = walkers.size();
}

void draw() {
	big.loadPixels();
	//First run: draw BG and init points
	if (walkers.size() == 0) {
    if(colorRamp){
      bg = rampBg; 
    }
		big.beginDraw();
		big.background(bg); //<>// //<>//
		big.noStroke(); //<>//
		big.fill(stuckColor);
		big.ellipse(w / 2, h / 2, radius, radius);
		big.endDraw();
		big.updatePixels();
		
		for (int i = 0; i < maxWalkers; i++) {
			float ang = random(TWO_PI);
			float len = random(maxRadius);
			PVector point = new PVector(w / 2 + cos(ang) * len, h / 2 + sin(ang) * len);
			// PVector point = new PVector(random(w), random(h));
			walkers.add(point); //<>//
		}
	} else{
		
		for (int n = 0; n < iterations; n++) {
			//move points
			for (int i = 0; i < walkers.size(); i++) {
				PVector point = walkers.get(i);
				PVector vel = PVector.random2D();
				PVector prevPoint = new PVector();
				prevPoint.x = point.x;
				prevPoint.y = point.y;
				point.add(vel);
				float curDist = dist(point.x, point.y, w / 2, h / 2);
				if (curDist >= maxRadius + feather) { //<>//
					point.x = prevPoint.x;
					point.y = prevPoint.y;
				}
				//float curAng = acos((point.x - w/2)/curDist) * Integer.signum(floor(h / 2 - point.y));
				//float xmax = w / 2 - cos(curAng) * (maxRadius + feather);
				//println(degrees(curAng));
				// point.x = constrain(point.x, max(0,w / 2 - cos(curAng) * (maxRadius + feather)), min(w, w / 2 + cos(curAng) * (maxRadius + feather))); //<>// //<>//
				// point.y = constrain(point.y, max(0,h / 2 + sin(curAng) * (maxRadius + feather)), min(h, h / 2 - sin(curAng) * (maxRadius + feather)));
				point.x = constrain(point.x, 0, w); //<>// //<>//
				point.y = constrain(point.y, 0, h);
				///check for collision
				if (big.pixels[constrain(floor(point.y),0,h - 1) * w + constrain(floor(point.x),0,w - 1)] != bg && random(1)<= stickieness) {
					if(colorRamp){
            stuckColor = WikiInterpolant.getGradientMonotonCubic((float) curDist, 100); 
          }
          big.beginDraw();
					big.noStroke();
					big.fill(stuckColor);
					big.ellipse(point.x, point.y, radius, radius);
					big.endDraw();
					if (curDist > maxRadius) {
						maxRadius = ceil(curDist);
						maxWalkers = floor(maxRadius * maxRadius * density);
					}
					walkers.remove(i);
					while(walkers.size() < maxWalkers && walkers.size() < hardcap) {
						float ang = random(TWO_PI);
						float len = random(maxRadius, maxRadius + feather);
						PVector newPoint = new PVector(w / 2 + cos(ang) * len, h / 2 + sin(ang) * len);
						//PVector point = new PVector(random(w), random(h));
						walkers.add(newPoint);
            curWalkerCount++;
						if (dist(point.x, point.y, 0, point.y) <= 0 ||
							dist(point.x, point.y, w, point.y) <= 0 ||
							dist(point.x, point.y, point.x, h) <= 0 ||
							dist(point.x, point.y, point.x, 0) <= 0) {
							done = true;
							break;
						}
					}
				}
			}
		}
	}
	big.updatePixels();
	movingG.beginDraw();
	movingG.clear();
	movingG.noStroke();
	movingG.fill(movingColor);
	for (int i = 0; i < walkers.size(); i++) {
		movingG.ellipse(walkers.get(i).x, walkers.get(i).y, radius, radius); //<>//
	}
	movingG.stroke(movingColor);
	movingG.noFill();
	movingG.ellipse(w / 2, h / 2, maxRadius * 2 + feather, maxRadius * 2 + feather);
	movingG.endDraw();
	
	image(big, 0, 0, width, height);
	image(movingG, 0,0,width, height);
	println("FPS : ", frameRate, "Walkers : ", maxWalkers);
  if (saveFrame &&  prevWalkerCount * saveTreshold <= curWalkerCount){
    prevWalkerCount = curWalkerCount;
    println("Saving Frame...");
    String frameNum = String.format("%06d",frameCount); 
    String picName = "pictures/" + seed + "/" + picCount + "/tree_" + frameNum + "_.png";
    PGraphics art = createGraphics(w,h);
    art.beginDraw();
    art.background(bg);
    art.image(big, margin, margin, w - 2 * margin, h - 2 * margin);
    art.save(picName);
    println("frame saved as : ", picName);
  }
	if (done) {
		println("Done generating");
		done = false;
		if (save) {
			println("Saving...");
			String picName = "pictures/tree_" + seed + "_" + picCount + ".png";
			PGraphics art = createGraphics(w,h);
			art.beginDraw();
			art.background(bg);
			art.image(big, margin, margin, w - 2 * margin, h - 2 * margin);
			art.save(picName);
			println("picture saved as : ", picName);
			picCount++;
		}
		if (picCount >= maxPic) {
			noLoop();
		} else{
			walkers = new ArrayList<PVector>();
      maxRadius = 30;
      maxWalkers = floor(maxRadius * maxRadius * density);
      big.clear();
      movingG.clear();
			if (randomColor) {
				bg	 = color(noise(random(seed)) * 255, noise(random(seed)) * 255, noise(random(seed)) * 255);
				stuckColor = color(noise(random(seed)) * 255, noise(random(seed)) * 255, noise(random(seed)) * 255, 80);
			}
		}
	}
	// noLoop();
} //<>//
