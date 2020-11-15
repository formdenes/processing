ArrayList<PVector> sources = new ArrayList<PVector>();
ArrayList<ArrayList<PVector>> fractures = new ArrayList<ArrayList<PVector>>();
// ArrayList<PVector> fracture = new ArrayList<PVector>();
ArrayList<PVector> masses;
IntList massCounters;
int sourceSize = 500;
int step = 20;
int FOW = 50;
int DENS = 10;


void setup(){
  size(500,500);
  ArrayList<PVector> fracture1 = new ArrayList<PVector>();
  // ArrayList<PVector> fracture2 = new ArrayList<PVector>();
  // ArrayList<PVector> fracture3 = new ArrayList<PVector>();
  // ArrayList<PVector> fracture4 = new ArrayList<PVector>();
  fracture1.add(new PVector(width/2, height));
  // fracture2.add(new PVector(width/2, FOW));
  // fracture3.add(new PVector(width-FOW, height/2));
  // fracture4.add(new PVector(FOW, height/2));
  fractures.add(fracture1);
  // fractures.add(fracture2);
  // fractures.add(fracture3);
  // fractures.add(fracture4);
  frameRate(4);
}

void draw(){
  sources = generateSources(sources, fractures);
  background(230);
  masses = new ArrayList<PVector>();
  massCounters = new IntList();
  for(int i = 0; i < fractures.size(); i++){
    masses.add(new PVector(0,0));
    massCounters.append(0);
  }
  for(int s = 0; s < sources.size(); s++){
    PVector source = sources.get(s);
    float minDist = FOW;
    Integer minF = null;
    Integer minN = null;
    fill(255, 0, 0);
    noStroke();
    circle(source.x, source.y, 2);
    for(int f = 0; f < fractures.size(); f++){
      ArrayList<PVector> fracture = fractures.get(f);
      for(int n = 0; n < fracture.size(); n++){
        PVector node = fracture.get(n);
        float _dist = dist(node.x, node.y, source.x, source.y);
        if(_dist <= minDist){
          minDist = _dist;
          minF = f;
          minN = n;
          // masses.get(f).x += source.x;
          // masses.get(f).y += source.y;
          // massCounters.set(f, massCounters.get(f) + 1);
          // sources.remove(s); //<>//
        }
      }
    }
    if(minF != null){
      masses.get(minF).x += source.x;
      masses.get(minF).y += source.y;
      massCounters.set(minF, massCounters.get(minF) + 1);
      sources.remove(s); //<>//
    }
  } //<>//
  for(int i = 0; i < fractures.size(); i++){
    masses.get(i).x = masses.get(i).x / massCounters.get(i);
    masses.get(i).y = masses.get(i).y / massCounters.get(i);
    stroke(0, 0, 255);
    strokeWeight(3);
    noFill();
    circle(masses.get(i).x, masses.get(i).y, 10);
  }
  // mass.x = mass.x / massCount;
  // mass.y = mass.y / massCount;
  for(int j = 0; j < fractures.size(); j++){
  beginShape();
    ArrayList<PVector> fracture = fractures.get(j);
    for(int i = 0; i < fracture.size(); i++){
      PVector node = fracture.get(i);
      stroke(0, 0, 0);
      strokeWeight(3);
      noFill();
      // circle(node.x, node.y, step);
      vertex(node.x, node.y);
      if (i == fracture.size()-1){
        strokeWeight(1);
        circle(node.x, node.y, FOW * 2);
        float xdist = masses.get(j).x - node.x;
        float ydist = masses.get(j).y - node.y;
        float nxdist = xdist / sqrt(xdist * xdist + ydist * ydist) * step;
        float nydist = ydist / sqrt(xdist * xdist + ydist * ydist) * step;
        // println(nxdist, nydist);
        PVector nNode = new PVector(node.x + nxdist, node.y + nydist); //<>//
        fracture.add(nNode); //<>//
        break; //<>//
      }
    }
    endShape(OPEN);
  }
  println(frameRate); //<>//
  // noLoop(); //<>//
}


ArrayList<PVector> generateSources(ArrayList<PVector> sources, ArrayList<ArrayList<PVector>> fractures){
  for(int n = 0; n < sourceSize; n++){
    PVector source = new PVector(random(0, width), random(0, height));
    boolean free = true;
    for(int i = 0; i < sources.size(); i++){
      float _dist = dist(source.x, source.y, sources.get(i).x, sources.get(i).y);
      if(_dist <= DENS){
        free = false;
        break;
      }
    }
    for(int i = 0; i < fractures.size(); i++){
      ArrayList<PVector> fracture = fractures.get(i);
      for(int j = 0; j < fracture.size(); j++){
        float _dist = dist(source.x, source.y, fracture.get(j).x, fracture.get(j).y);
        if(_dist <= DENS){
        free = false;
        break;
        }
      }
      if(!free){break;}
    }
    if(free){
      sources.add(source);
    }
  }
  return sources;
}
