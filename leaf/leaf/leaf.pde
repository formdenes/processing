ArrayList<PVector> sources = new ArrayList<PVector>();
ArrayList<ArrayList<PVector>> fractures = new ArrayList<ArrayList<PVector>>();
// ArrayList<PVector> fracture = new ArrayList<PVector>();
ArrayList<PVector> masses;
IntList massCounters;
int sourceSize = 10000;
int step = 5;
int FOW = 150;
int DENS = 5;


void setup(){
  size(1000,1000);
  sources = generateSources(sources);
  ArrayList<PVector> fracture1 = new ArrayList<PVector>();
  ArrayList<PVector> fracture2 = new ArrayList<PVector>();
  ArrayList<PVector> fracture3 = new ArrayList<PVector>();
  ArrayList<PVector> fracture4 = new ArrayList<PVector>();
  fracture1.add(new PVector(width/2, height-FOW));
  fracture2.add(new PVector(width/2, FOW));
  fracture3.add(new PVector(width-FOW, height/2));
  fracture4.add(new PVector(FOW, height/2));
  fractures.add(fracture1);
  fractures.add(fracture2);
  fractures.add(fracture3);
  fractures.add(fracture4);
  frameRate(30);
}

void draw(){
  sources = generateSources(sources);
  background(230);
  masses = new ArrayList<PVector>();
  massCounters = new IntList();
  for(int i = 0; i < fractures.size(); i++){
    masses.add(new PVector(0,0));
    massCounters.append(0);
  }
  for(int i = 0; i < sources.size(); i++){
    PVector source = sources.get(i);
    fill(255, 0, 0);
    noStroke();
    circle(source.x, source.y, 2);
    for(int j = 0; j < fractures.size(); j++){
      ArrayList<PVector> fracture = fractures.get(j);
      PVector node = fracture.get(fracture.size() -1);
      float _dist = dist(node.x, node.y, source.x, source.y);
      if(_dist <= FOW){
        masses.get(j).x += source.x;
        masses.get(j).y += source.y;
        massCounters.set(j, massCounters.get(j) + 1);
        sources.remove(i); //<>//
      }
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


ArrayList<PVector> generateSources(ArrayList<PVector> sources){
  while(sources.size() < sourceSize){
    PVector source = new PVector(random(-FOW, width + FOW), random(-FOW, height + FOW));
    boolean free = true;
    for(int i = 0; i < sources.size(); i++){
      float _dist = dist(source.x, source.y, sources.get(i).x, sources.get(i).y);
      if(_dist <= DENS){
        free = false;
        break;
      }
    }
    if(free){
      sources.add(source);
    }
  }
  return sources;
}
