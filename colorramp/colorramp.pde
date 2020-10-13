color[] points = {color(0, 7, 100), color(32, 107, 203), color(237, 255, 255), color(255, 170, 0), color(0, 2, 0)};
Interpolant WikiInterpolant;

void setup(){
  size(1920,500);
 colorMode(RGB);
 WikiInterpolant = new Interpolant((float) width, points, false);
}

void draw(){
  loadPixels();
  for (int i = 0; i < width; i++){
     color col1 = getGradientLinear((float) i, (float) width, points, false);
     color col2 = WikiInterpolant.getGradientMonotonCubic((float) i);
   for (int j = 0; j < height; j++){
     if (j <= height/2){
     pixels[i + j * width] = col1;
     } else {
       pixels[i + j * width] = col2;
     }

   }
  }
  updatePixels();
  noLoop();
}


color getGradient2Linear(float loc, float max, color start, color end) {
  int red = floor(map(loc, 0, max, red(start), red(end)));
  int green = floor(map(loc, 0, max, green(start), green(end)));
  int blue = floor(map(loc, 0, max, blue(start), blue(end)));
  color col = color (red, green, blue);
  return col;
}

color getGradientLinear(float loc, float max, color[] points){
 return getGradientLinear(loc, max, points, false); 
}

color getGradientLinear(float loc,float max, color[] points, boolean loop) {
  int size = points.length;
  int section;
  if (loop) {
    section = floor(max / (size));
  } else {
    section = floor(max / (size - 1));
  }
  int curSec = constrain(floor(loc / section),0,size -1);
  int relLoc = floor(loc - (section * curSec));
  int nextSec;
  if (curSec >= size - 1) {
    nextSec = 0;
  } else {
    nextSec = curSec + 1;
  }
  //println(relLoc);
  //println(section);
  //println(curSec);
  //println(nextSec);
  return getGradient2Linear(relLoc, section, points[curSec], points[nextSec]);
}
