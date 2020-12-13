class Fractures{
  ArrayList<Node> nodes;

  Fractures(Node node){
    nodes = new ArrayList<Node>();
    nodes.add(node);
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
      node.norm();
    }
  }

  void showNorms(){
    for(Node node : nodes){
      node.showNorms();
    }
  }

  void calcMasses(){
    for(Node node : nodes){
      node.calcMass();
    }
  }

  void showMasses(){
    for(Node node : nodes){
      node.showMass();
    }
  }

  void addNodes(){
    int size = nodes.size();
    for(int i = 0; i < size; i++){
      Node node = nodes.get(i);
      if(node.nextNode == null && !(node.mass.x == 0 && node.mass.y ==0)){
        Node newNode = new Node(node.pos.x + node.mass.x + STEP, node.pos.y + node.mass.y * STEP);
        node.nextNode = newNode;
        newNode.prevNode = node;
        nodes.add(newNode);
      }
    }
  }
}
