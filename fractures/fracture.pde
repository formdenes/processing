class Fracture{
  Node endNode;
  ArrayList<Node> nodes;
  boolean terminated;
  float fov;

  Fracture(Node node){
    nodes = new ArrayList<Node>();
    nodes.add(node);
    terminated = false;
    fov = random(minFov, FOV);
    endNode = nodes.get(nodes.size() - 1);
  }

  void show(color col, float size){
    show(col, size, false);
  }

  void show(color col, float size, boolean showNode) {
    for (Node node : nodes){
      if (showNode) {node.show(col, fov);}
      PVector prevPos = new PVector();
      if (node.prevNode != null){ prevPos = node.prevNode.pos;}
      else {prevPos = node.pos;}
      noFill();
      stroke(col);
      strokeWeight(1);
      line(node.pos.x, node.pos.y, prevPos.x, prevPos.y);
    }
  }

  void norm(){
    if(!terminated){endNode.norm();}
    // for (Node node : nodes){
    //   node.norm(); //<>// //<>//
    // }
  } //<>//

  void showNorms(){
    endNode.showNorms();
    // for(Node node : nodes){
    //   node.showNorms();
    // }
  }

  ArrayList<PVector> calcMasses(){
    ArrayList<PVector> sourcesToRemove = new ArrayList<PVector>();
    if(!terminated){
      sourcesToRemove.addAll(endNode.calcMass());
    }
    // for(Node node : nodes){
    //   sourcesToRemove.addAll(node.calcMass());
    // }
    return sourcesToRemove;
  }

  void showMasses(){
    endNode.showMass();
    // for(Node node : nodes){
    //   node.showMass();
    // }
  }

  void addNode(ArrayList<Fracture> fractures){
    if(!terminated){
      // int size = nodes.size();
      Node node = endNode;
      // if(!terminated && node.nextNode == null && !(node.mass.x == 0 && node.mass.y ==0)){
      if(!(node.sources.size() == 0)){
        Node newNode = new Node(node.pos.x + node.mass.x * STEP, node.pos.y + node.mass.y * STEP);
        node.nextNode = newNode;
        newNode.prevNode = node;
        nodes.add(newNode);
        endNode = nodes.get(nodes.size() - 1);
      } else {
        terminated = true;
      }
      terminate(fractures);
    }
  }

  void addNode(Node node, ArrayList<Fracture> fractures){
    if(!terminated){
      Node currNode = nodes.get(nodes.size() - 1);
      Node newNode = node;
      currNode.nextNode = newNode;
      newNode.prevNode = currNode;
      nodes.add(newNode);
      endNode = nodes.get(nodes.size() - 1);
      terminate(fractures);
    }
  }

  boolean terminate(ArrayList<Fracture> fractures){
    PVector pos = endNode.pos;
    if (!terminated){
      if (outOfBound(pos)){
        terminated = true;
      }
      else{
        for(int f = 0; f < fractures.size() && !terminated; f++){
          if(f != fractures.indexOf(this)){
            Fracture fracture = fractures.get(f);
            for(int n = 0; n < fracture.nodes.size() && !terminated; n++){
              Node node = fracture.nodes.get(n);
              if(pointCircle(pos.x, pos.y, node.pos.x, node.pos.y, fsize / 2)){
                terminated = true;
                break;
              }
            }
          }
        }
      }
    }
    return terminated;
  }

  boolean outOfBound(PVector pos){
    if(pos.x > width ||
       pos.x < 0 ||
       pos.y > height ||
       pos.y < 0){
         return true;
       }
    else {return false;}
  }
}

boolean pointCircle(float px, float py, float cx, float cy, float r) {

  // get distance between the point and circle's center
  // using the Pythagorean Theorem
  float distX = px - cx;
  float distY = py - cy;
  float distance = sqrt( (distX*distX) + (distY*distY) );

  // if the distance is less than the circle's
  // radius the point is inside!
  if (distance <= r) {
    return true;
  }
  return false;
}