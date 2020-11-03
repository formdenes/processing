ArrayList<PVector> walkers;
PGraphics movingG;
PGraphics big; 
int w = 500;
int h = 500;
float res = 1;
int iterations = 1000;
int maxWalkers = 500;

float maxRadius = 3;
color bg = color(255);
color movingColor = color(255, 255, 255);
color stuckColor = color(25, 50);

void settings(){
  size(floor(w*res),floor(h*res));
  smooth(8);
}

void setup(){
  big = createGraphics(w,h);
  movingG = createGraphics(w,h);
  walkers = new ArrayList<PVector>();
}

void draw(){
  if (walkers.size() == 0){
    big.beginDraw();
    big.background(bg);
    big.noStroke();
    big.fill(stuckColor);
    big.ellipse(w/2, h/2, maxRadius, maxRadius);
    big.endDraw();
    
    movingG.beginDraw();
    movingG.background(bg);
    movingG.noStroke();
    movingG.fill(stuckColor);
    movingG.ellipse(w/2, h/2, maxRadius, maxRadius);
    movingG.endDraw();
    for (int i = 0; i < maxWalkers; i++){
      PVector point = new PVector(random(w), random(h));
      walkers.add(point);
    }
  } else{
    
  }  
  movingG.beginDraw();
  movingG.noStroke();
  movingG.fill(movingColor);
  background(bg);
  for (int i = 0; i < walkers.size(); i++) {
    noStroke();
    fill(movingColor);
    ellipse(walkers.get(i).x, walkers.get(i).y, maxRadius, maxRadius);
    movingG.ellipse(walkers.get(i).x, walkers.get(i).y, maxRadius, maxRadius);
  }
  movingG.endDraw();
  
  //image(movingG, 0,0,width, height);
  noLoop(); //<>//
}
