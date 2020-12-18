final int length = 100;
final int w = 3000;
final int h = 3000;
final color bg = color(240);
final color line = color(20);
final boolean generateColor = true;
final boolean saveing = true;
final int picNum = 10;

String seed = "0";
color randomColor;


PGraphics big;
color[] colors;
Interpolant interpolant;

int margin = 50;

int counter = 0;

void settings(){
	float res = min(displayWidth / (float) w, displayHeight / (float) h * 9 / 10);
	size(floor(w * res), floor(h * res), P2D);
	// smooth(8);
}

void setup() {
  seed = nf(floor(random(1000000)),6);
	//  seed = "985644";
	randomSeed(Integer.parseInt(seed));
	big = createGraphics(w, h, P2D);
	big.smooth(8);
	randomColor = color(random(255), random(255), random(255));
	colors = getNiceColors(randomColor);
	interpolant = new Interpolant((float) h, colors, false);
	margin = w/12;
	// println(colors);
} 

void draw(){
	setup();
	background(bg);
  big.beginDraw();
	// big.background(bg);
	int iter = floor(w / length * h / length);
	for (int i = 0; i < iter; i++) {
		int angle = round(random(1)); //<>// //<>//
		int x = floor(i % (w / length)) * length;
		int xx = floor(i % (w / length) + 1) * length;
		int y;
		int yy;
		if (angle == 0) {
	    y = floor(i / (h / length)) * length;
      yy = floor(i / (h / length) + 1) * length;
		} else {
      yy = floor(i / (h / length)) * length;
      y = floor(i / (h / length) + 1) * length;
		}
		betterLine(x, y, xx, yy, color(line), length / 10, big);
		// big.noFill();
    // big.stroke(20);
    // big.strokeWeight(length / 10); //<>//
    // big.line(x, y, xx, yy);
    // big.stroke(20,50);
    // big.strokeWeight(length / 10 * 2);
    // big.line(x, y, xx, yy);
	} //<>//
	//Tint effect with gradient
	big.loadPixels();
	if(generateColor){
		big.colorMode(HSB, 255);
		for(int x = 0; x < w; x++){
			for(int y = 0; y < h; y++){
				color currPixel = big.pixels[x + (y * w)];
				float h = hue(currPixel); //<>//
				float s = saturation(currPixel);
				float b = brightness(currPixel); //<>//
				float a = alpha(currPixel);

				if(b < 200){ //<>//
					color _col = interpolant.getGradientMonotonCubic((float) y, floor(a));
					big.pixels[x + (y * w)] = _col;
					// big.pixels[x + (y * w)] = color(hue(randomColor), saturation(randomColor), brightness(randomColor), a); //<>// //<>//
				}
			}
		}
		big.colorMode(RGB, 255);
		big.updatePixels();
	}
  big.endDraw();
  image(big, margin, margin, width - 2 * margin, height - 2 * margin);
	if(saveing){
		save("lines_" + seed);
		if(counter < picNum){
			counter++;
		} else {
			println("END");
			noLoop();
			exit();
		}
	}
}

void betterLine(float x, float y, float xx, float yy, color col, float s, PGraphics g){
	g.noFill();
	g.stroke(col);
	g.strokeWeight(s);
	g.line(x, y, xx, yy);
	for(int n = 0; n < 6; n++){
		g.stroke(col, 10);
		g.strokeWeight(s*pow(1.1, n));
		g.line(x, y, xx, yy);
	}
}

void save(String name){
	println("Saving...");
	String picName = "pictures/" + name + ".png";
	PGraphics art = createGraphics(w, h, P2D); //<>//
	art.beginDraw();
	art.background(bg); //<>//
	art.image(big, margin, margin, w - 2 * margin, h - 2 * margin);
	art.save(picName);
	println("picture saved as: ", picName);
}


color[] getNiceColors(color col){
  String hex = hex(col, 6);
  String url = "https://www.thecolorapi.com/scheme?hex=" + hex + "&mode=analogic&count=6&format=json";
  // println(url);
  JSONObject json = loadJSONObject(url);
	color[] colors = new color[6];
	for (int i = 0; i < colors.length; i++){
		colors[i] = unhex("FF" + json.getJSONArray("colors").getJSONObject(i).getJSONObject("hex").getString("clean"));
	}
  return colors;
}
