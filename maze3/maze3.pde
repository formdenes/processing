final int STEP = 20;
final int w = 800;
final int h = 1000;

final color bg = color(240);
final boolean saving = false;
final int picNum = 1;


PGraphics pg;
Interpolant interpolant;
color[] colors;
color randomColor;
ArrayList<Node> nodes;
int counter = 0;
String seed = "0";
float margin = 100;
float amp;

void settings(){
  float res = min(displayWidth / (float) w, displayHeight / (float) h * 9 / 10);
  size(floor(w * res), floor(h * res), P2D);
}

void setup(){
  margin = w/12;
  amp = STEP / 10 * 2;
  seed = setSeed("303524");
  pg = createGraphics(w, h, P2D);
  pg.smooth(8);
  nodes = new ArrayList<Node>();
  randomColor = color(random(255), random(255), random(255));
  colors = getNiceColors(randomColor);
  interpolant = new Interpolant((float) h, colors, false);
}

void draw(){
  setup();
  pg.beginDraw();
  for(int y = 0; y < ((h - 2*STEP) / STEP )+ 1; y++){
    for(int x = 0; x < (w - 2*STEP) /STEP + 1; x++){
      PVector noise = PVector.fromAngle(random(TWO_PI)).mult(random(amp));
      nodes.add(new Node(STEP + x * STEP + noise.x, STEP + y * STEP + noise.y));
    }
  }

  for(int i = 0; i < nodes.size(); i++){
    int ind = floor(random(nodes.size()));
    while(nodes.get(ind).nextPos != null){
      ind = floor(random(nodes.size()));
    }
    Node node = nodes.get(ind);
    int r = floor(random(4));
    Node nextNode = nodes.get(getIndex(ind, r));
    for(int n = 0; n < 4; n++){
      if(nextNode.prevPos == null){
        node.nextPos = nextNode.pos;
        nextNode.prevPos = node.pos;
        node.dir = r;
        break;
      }else{
        r = (r + 1) % 4;
        nextNode = nodes.get(getIndex(ind, r));
      }
    }
    if(node.nextPos == null){
      node.nextPos = node.pos;
    }
  }

  pg.stroke(20);
  pg.fill(240, 20, 20);
  pg.textSize(12);
  for(int i = 0; i < nodes.size(); i++){
    Node node = nodes.get(i);
    betterLine(node.pos.x, node.pos.y, node.nextPos.x, node.nextPos.y, color(0), STEP / 10.0, pg);
  }
  tint(pg, interpolant);
  pg.endDraw();
  image(pg, 0, 0, width, height);
  if(saving){ 
    save("maze_" + seed, plotArt(pg, bg, margin, w, h), w, h); 
    if(counter < picNum - 1){ 
      counter++; 
    } else {
      println("END");
      noLoop();
      exit();
    }
  }
  else{
    noLoop();
  }
}

class Node {
  PVector pos;
  PVector prevPos;
  PVector nextPos;
  int dir;

  Node(){
    pos = new PVector(random(w), random(h));
  }

  Node(float x, float y){
    pos = new PVector(x, y);
  }
} 

int getIndex(int curInd, int dir){
  int nextInd = curInd;
  if(dir == 0){
    if(curInd % ((w - 2*STEP)/STEP+1) != (w - 2*STEP)/STEP){nextInd = curInd + 1;}
  }else if(dir == 1){
    if(curInd > (w - 2*STEP)/STEP){nextInd = floor(curInd - ((w - 2*STEP)/STEP+1));}
  }else if(dir == 2){
    if(curInd % ((w - 2*STEP)/STEP + 1) != 0){nextInd = curInd - 1;}
  }else if(dir == 3){
    if(curInd < (w - 2*STEP)/STEP*((h - 2*STEP)/STEP+1)){nextInd = floor(curInd + ((w - 2*STEP)/STEP+1));}
  }
  return nextInd;
}
