//ArrayList<PVector> points;
ArrayList<ArrayList<PVector>> lines;
int lc = 0;
int pc = 0;
int wd = 2;
int hd = 3;
int spd = 1000;
float xoff = 0;
boolean loop = true;
float noiseRange = 10;
int seed = parseInt(String.valueOf(floor(random(1000000,10000000))).substring(1));

void setup(){
  size(1000, 1000, P2D);
  smooth(16);
  println(seed);
  noiseSeed(seed);
  lines = new ArrayList<ArrayList<PVector>>();
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
      if(pc < height/hd){
        if(pc == 0){lines.add(new ArrayList<PVector>());}
        PVector point;
        if(lc == 0){point = getNewPoint(lc, pc);}
        else{point = getNewPoint(lc, pc, lines.get(lc-1).get(pc).x);}
        lines.get(lc).add(point);
        pc++;
        xoff+=0.01;
      }else {
        lc++;
        pc = 0;
      }
  }
  
  
  
  background(245);
  noFill();
  stroke(0);
  strokeWeight(0.5);
  //println(lines.size());
  for(int j = 0; j < lines.size(); j++){
    beginShape();
    ArrayList<PVector> points = lines.get(j);
    int outOfBoundCount = 0;
    for (int i = 0; i < points.size(); i++){
      //println("line:", j, "x:", points.get(i).x, "y:", points.get(i).y);
      vertex(points.get(i).x, points.get(i).y);
      if (j == lines.size() - 1 && points.get(i).x > width){
        outOfBoundCount++;
      }
      if (outOfBoundCount > points.size()){noLoop();}
    }
    endShape();
  }
  //noLoop();
}


PVector getNewPoint(int x, int y){
  float xpos = x*(wd+1) + (map(noise(xoff),0,1,-noiseRange,noiseRange));
  PVector v = new PVector(xpos,y*(hd+1));
  return v;
}

PVector getNewPoint(int x, int y, float prevx){
  float xpos = prevx + wd + (map(noise(xoff),0,1,-noiseRange,noiseRange));
  PVector v = new PVector(xpos,y*(hd+1));
  return v;
}
