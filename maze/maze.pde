final int STEP = 10;
final int w = 500;
final int h = 500;

final color bg = color(240);

ArrayList<Node> nodes;


void settings(){
  size(w,h,P2D);
}

void setup(){
  // hint(DISABLE_ASYNC_SAVEFRAME);
  // big = createGraphics(w, h, P2D);
	// big.smooth(8);
  nodes = new ArrayList<Node>();
  for(int y = 0; y < h / STEP + 1; y++){
    for(int x = 0; x < w / STEP+ 1; x++){
      nodes.add(new Node(x * STEP, y * STEP));
    }
  }
  try{
  for(int i = 0; i < nodes.size(); i++){
    Node node = nodes.get(i);
    int r = floor(random(4));
    Node nextNode = nodes.get(getIndex(i, r));
    for(int n = 0; n < 4; n++){
      if(nextNode.prevNode == null){
        node.nextNode = nextNode;
        nextNode.prevNode = node;
        break;
      }else{
        r = (r + 1) % 4;
        nextNode = nodes.get(getIndex(i, r));
      }
    }
    if(node.nextNode == null){
      node.nextNode = node;
    }
  }
  }
  catch(Exception e){
    println(e);
  }
}

void draw(){
  background(bg);
  stroke(20);
  fill(240, 20, 20);
  textSize(12);
  for(int i = 0; i < nodes.size(); i++){
    Node node = nodes.get(i);
    // circle(node.pos.x, node.pos.y, 3);
    line(node.pos.x, node.pos.y, node.nextNode.pos.x, node.nextNode.pos.y);
    // text(i, node.pos.x, node.pos.y); //<>//
    //  int ind = nodes.indexOf(node.nextNode);
    //  text(ind, node.pos.x, node.pos.y); //<>//
  }
  noLoop();
}

class Node{
  Node prevNode;
  Node nextNode; //<>//
  PVector pos;

  Node(){
    pos = new PVector(random(width), random(height));
  }
  Node(float x, float y){
    pos = new PVector(x,y);
  } //<>//
}

int getIndex(int curInd, int dir){ //<>//
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
  // return (constrain(nextInd, 0, max);)
  return nextInd;
}

/*
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
*/
