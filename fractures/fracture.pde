class Fracture{
  Node endNode;
  ArrayList<Node> nodes;
  boolean terminated;
  float fov;

  Fracture(Node node){
    nodes = new ArrayList<Node>();
    nodes.add(node);
    terminated = false;
    fov = random(FOV);
    endNode = nodes.get(nodes.size() - 1);
  }

  void show(color col, float size){
    show(col, size, false);
  }

  void show(color col, float size, boolean showNode) {
    for (Node node : nodes){
      if (showNode) {node.show(col, size);}
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
    for (Node node : nodes){
      node.norm(); //<>// //<>//
    }
  } //<>//

  void showNorms(){
    for(Node node : nodes){
      node.showNorms();
    }
  }

  ArrayList<PVector> calcMasses(){
    ArrayList<PVector> sourcesToRemove = new ArrayList<PVector>();
    for(Node node : nodes){
      sourcesToRemove.addAll(node.calcMass());
    }
    return sourcesToRemove;
  }

  void showMasses(){
    for(Node node : nodes){
      node.showMass();
    }
  }

  void addNode(){
    int size = nodes.size();
    Node node = endNode;
    if(!terminated && node.nextNode == null && !(node.mass.x == 0 && node.mass.y ==0)){
        Node newNode = new Node(node.pos.x + node.mass.x + STEP, node.pos.y + node.mass.y * STEP);
        node.nextNode = newNode;
        newNode.prevNode = node;
        nodes.add(newNode);
    }
    endNode = nodes.get(nodes.size() - 1);
  }

  void addNode(Node node){
    Node currNode = nodes.get(nodes.size() - 1);
    Node newNode = node;
    currNode.nextNode = newNode;
    newNode.prevNode = currNode;
    nodes.add(newNode);
    endNode = nodes.get(nodes.size() - 1);
  }

  boolean terminate(){
    PVector pos = endNode.pos;
    if (outOfBound(pos)){
      terminated = true;
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
