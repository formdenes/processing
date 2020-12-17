final int STEP = 100;
final int w = 1000;
final int h = 1000;

final color bg = color(240);

PGraphics pg;
ArrayList<Node> nodes;

void settings(){
  size(w,h,P2D);
}

void setup(){
  pg = createGraphics(w, h, P2D);
  nodes = new ArrayList<Node>();
}

void draw(){
  pg.beginDraw();
  for(int y = 0; y < (h / STEP )+ 1; y++){
    for(int x = 0; x < w /STEP + 1; x++){
      nodes.add(new Node(x * STEP, y * STEP));
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

  pg.background(bg);
  pg.stroke(20);
  pg.fill(240, 20, 20);
  pg.textSize(12);
  for(int i = 0; i < nodes.size(); i++){
    Node node = nodes.get(i);
    betterLine(node.pos.x, node.pos.y, node.nextPos.x, node.nextPos.y, color(0), STEP / 10, pg);
  }
  pg.endDraw();
  image(pg, 0, 0, width, height);
  noLoop();
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
    if(curInd % (w/STEP+1) != w/STEP){
      nextInd = curInd + 1;
    }
  }else if(dir == 1){
    if(curInd > w/STEP){nextInd = floor(curInd - (w/STEP+1));}
  }else if(dir == 2){
    if(curInd % (w/STEP + 1) != 0){nextInd = curInd - 1;}
  }else if(dir == 3){
    if(curInd < w/STEP*(w/STEP+1)){nextInd = floor(curInd + (w/STEP+1));}
  }
  return nextInd;
}
