PVector pos, pmouse, cmouse;
int maxiterations = 100;
float zoom = 1.0;
int[][] points = {{0, 7, 100}, {32, 107, 203}, {237, 255, 255}, {255, 170, 0}, {0, 2, 0}};
boolean drag = false;

void setup() {
  float xstart = 0.0;
  float ystart = 0.0;
  pos = new PVector(xstart, ystart);
  
  pmouse = new PVector();
  cmouse = new PVector();
  size(500, 500);
  pixelDensity(1);
  colorMode(RGB);

  //points[0] = {0, 7, 100};
  //points[1] = {32, 107, 203};
  //points[2] = {237, 255, 255};
  //points[3] = {255, 170, 0};
  //points[4] = {0, 2, 0};
}
void draw() {
  background(255);
  //float w = 5;
  //float h = (w * height) / width;

  // Start at negative half the width and height
  //float xmin = -w/2;
  //float ymin = -h/2;

  // Make sure we can write to the pixels[] array.
  // Only need to do this once since we don't do any other drawing.
  loadPixels();

  //// Maximum number of iterations for each point on the complex plane
  //int maxiterations = 100;

  //// x goes from xmin to xmax
  //float xmax = xmin + w;
  //// y goes from ymin to ymax
  //float ymax = ymin + h;

  //// Calculate amount we increment x,y for each pixel
  //float dx = (xmax - xmin) / (width);
  //float dy = (ymax - ymin) / (height);

  //// Start y
  //float y = ymin;
  //for (int j = 0; j < height; j++) {
  //  // Start x
  //  float x = xmin;
  //  for (int i = 0; i < width; i++) {

  //    // Now we test, as we iterate z = z^2 + cm does z tend towards infinity?
  //    float a = x;
  //    float b = y;
  //    int n = 0;
  //    while (n < maxiterations) {
  //      float aa = a * a;
  //      float bb = b * b;
  //      float twoab = 2.0 * a * b;
  //      a = aa - bb + x;
  //      b = twoab + y;
  //      // Infinty in our finite world is simple, let's just consider it 16
  //      if (a*a + b*b > 16.0) {
  //        break;  // Bail
  //      }
  //      n++;
  //    }

  //    // We color each pixel based on how long it takes to get to infinity
  //    // If we never got there, let's pick the color black
  //    if (n == maxiterations) {
  //      pixels[i+j*width] = color(0);
  //    } else {
  //      // Gosh, we could make fancy colors here if we wanted
  //      pixels[i+j*width] = color(sqrt(float(n) / maxiterations));
  //    }
  //    x += dx;
  //  }
  //  y += dy;
  //}
  float zm = 4 / (pow(2, zoom));
  for (int x = 0; x < width; x++){
    for (int y = 0; y < height; y++){
      float a = map(x, 0, width, pos.x - zm, pos.x + zm);
      float b = map(y, 0, width, pos.y - zm, pos.y + zm);
      
      float ca = a;
      float cb = b;
      
      int n = 0;
      
      while (n < maxiterations) {
        float aa = a * a - b * b;
        float bb = 2 * a * b;
        
        a = aa + ca;
        b = bb + cb;
        
        if (abs(a + b) > 16){
          break; 
        }
        
        n++;
      }
      
      int[] rgb = getGradient(n, 100, points);
      pixels[x + y * width] = color(rgb[0],rgb[1],rgb[2]);
      
      //if (n == maxiterations) {
      //  pixels[x+y*width] = color(0);
      //} else {
      //  // Gosh, we could make fancy colors here if we wanted
      //  pixels[x+y*width] = color(sqrt(float(n) / maxiterations));
      //}
      
    }
  }
  
  updatePixels();
  println(frameRate);
}

int[] getGradient2(int loc, int max, int[] start, int[] end) {
  int[] pos = new int[3];
  pos[0] = floor(map(loc, 0, max, start[0], end[0]));
  pos[1] = floor(map(loc, 0, max, start[1], end[1]));
  pos[2] = floor(map(loc, 0, max, start[2], end[2]));
  return pos;
}

int[] getGradient(int loc,int max, int[][] points) {
  int size = points.length;
  int section;
  //if (loop) {
    //section = floor(max / (size));
  //} else {
    section = max / (size - 1);
  //}
  int curSec = constrain(floor(loc / section),0,size -1);
  int relLoc = loc - (section * curSec);
  int nextSec;
  if (curSec >= size - 1) {
    nextSec = 0;
  } else {
    nextSec = curSec + 1;
  }
  //println(relLoc);
  //println(section);
  //println(curSec);
  //println(nextSec); //<>//
  return getGradient2(relLoc, section, points[curSec], points[nextSec]);
}
