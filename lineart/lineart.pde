//ArrayList<PVector> points;
ArrayList<ArrayList<PVector>> lines;
PGraphics big;
int w = 2000;
int h = 3000;
float res = 0.3;
int lc = 0;
int pc = 0;
int wd = 2;
int hd = 3;
int spd = 5000;
int margin = 100;
int rheight;
int rwidth;
float xoff = 0;
boolean loop = true;
float noiseRange = 10;
int seed = parseInt(String.valueOf(floor(random(1000000,10000000))).substring(1));
//color col = color(242,197,61, 80);
color col;
//color bg = color(82,1,32);
color bg;
boolean stop = false;
int picCount = 0;
int picNum = 4;

void settings(){
  size(floor(w * res), floor(h * res), P2D);
  smooth(8);
}

void setup(){
  big = createGraphics(w,h);
  println(seed);
  noiseSeed(seed);
  randomSeed(seed);
  bg = color(randomGaussian() * 255, randomGaussian() * 255, randomGaussian() * 255);
  col = color(randomGaussian() * 255, randomGaussian() * 255, randomGaussian() * 255);
  lines = new ArrayList<ArrayList<PVector>>();
  rheight = h - 2*margin;
  rwidth = w - 2*margin;
  //for(int j = 0; j < width/10; j++){
  //  ArrayList<PVector> points = new ArrayList<PVector>();
  //  for(int i = 0; i < height/5; i++){
  //    float x = j*10 + (map(noise(i*0.1),0,1,-5,5));
  //    points.add(new PVector(x,i*5));
  //  }
  //  lines.add(points);
  //}
}

void draw(){
  //ArrayList<PVector> cLine;
  
  for(int n = 0; n < spd; n++){
      if(pc < rheight/hd){
        if(pc == 0){lines.add(new ArrayList<PVector>());}
        PVector point;
        if(lc == 0){point = getNewPoint(lc, pc);}
        else{point = getNewPoint(lc, pc, lines.get(lc-1).get(pc).x);}
        lines.get(lc).add(point);
        pc++;
        xoff+=0.01;
        if(pc == rheight/hd){
          int outOfBoundCount = 0;
          for(int i = 0; i < pc; i++){
            if (lines.get(lc).get(i).x > rwidth){outOfBoundCount++;}
          }
          if(pc -1  <= outOfBoundCount || lc > w){
          stop = true;
          println("Done");
          break; //<>//
        }
        }
      }else {
        lc++;
        pc = 0;
      }
  }
  
  
  big.beginDraw();
  big.background(bg);
  //fill(255, 0, 0);
  //ellipse(0, 0, 10,10);
  big.noFill();
  big.stroke(col);
  big.strokeWeight(0.5);
  //println(lines.size());
  big.translate(margin, margin);
  //fill(255, 0, 0);
  //ellipse(0, 0, 10,10);
  //noFill();
  for(int j = 0; j < lines.size(); j++){
    big.beginShape();
    ArrayList<PVector> points = lines.get(j);
    //int outOfBoundCount = 0;
    //println(points.size());
    for (int i = 0; i < points.size(); i++){
      //println("line:", j, "x:", points.get(i).x, "y:", points.get(i).y);
      float xpos = points.get(i).x;
      float ypos = points.get(i).y;
      //if (xpos < rwidth && ypos < rheight){
      big.vertex(xpos, ypos);
    //}
      //if (j == lines.size() - 1 && xpos > rwidth){
      //  outOfBoundCount++;
      //  fill(255, 0, 0);
      //  ellipse(xpos, ypos, 2,2);
      //  noFill();
      //  //println("target: ", points.size(), "OoBC: ", outOfBoundCount);
      //}
      //if (outOfBoundCount >= lines.get(0).size()){
      //  //println("done");
      //  //noLoop();
      //}
    }
    big.endShape();
  }
  big.noStroke();
  big.fill(bg);
  big.rect(rwidth,0,margin, rheight);
  big.endDraw();
  image(big,0,0,width, height);
  //rect(-margin,rheight,rwidth+ 2*margin, rheight + margin);
  if(stop){
    println("saving...");
    String picName = "pictures/" + seed + "/line_" + picCount + ".png";
    big.save(picName);
    println("picture saved as:", picName);
    //noLoop();
    bg = color(randomGaussian() * 255, randomGaussian() * 255, randomGaussian() * 255);
    col = color(randomGaussian() * 255, randomGaussian() * 255, randomGaussian() * 255);
    lines = new ArrayList<ArrayList<PVector>>();
    picCount++;
    lc = 0;
    pc = 0;
    stop = false;
    if (picCount >= picNum){noLoop();}
  }
}


PVector getNewPoint(int x, int y){
  float xpos = x*(wd+1) + (map(noise(xoff),0,1,-noiseRange,noiseRange));
  PVector v = new PVector(xpos,y*(hd));
  return v;
}

PVector getNewPoint(int x, int y, float prevx){
  float xpos = prevx + wd + (map(noise(xoff),0,1,-noiseRange,noiseRange));
  PVector v = new PVector(xpos,y*(hd));
  return v;
}
