class Vein {
  ArrayList<Node> nodes;

  Vein(Node node) {
		nodes = new ArrayList<Node>();
    nodes.add(node);
	}

  void addNode(Node node){
    nodes.add(node);
  }

  Node getNode(int index){
    return nodes.get(index);
  }

  void show(color col, float size){
    show(col, size, false);
  }

  void show(color col, float size, boolean showNode) {
    for(int i = 0; i < nodes.size(); i++){
      nodes.get(i).weight = 0;
    }
    for(int i = nodes.size() - 1; i >= 0; i--){
      Node node = nodes.get(i);
      if(node.childNode == 0){
        node.weight = minWidth;
      }
      else{
        node.weight = pow(node.weight, 1.0/exponent);
      }
      Node parentNode = nodes.get(node.prevNode);
      parentNode.weight += pow(node.weight, exponent);
    }
    for (int i = 0; i < nodes.size(); i++){
      Node node = nodes.get(i);
      if(showNode) {node.show(col, size);}
      // if (i >= 1) {
      //   Node prevNode = nodes.get(i-1);
        stroke(col);
        strokeWeight(node.weight);
	    	line(node.pos.x, node.pos.y, nodes.get(node.prevNode).pos.x, nodes.get(node.prevNode).pos.y);
			// }
    }
  }

  int size(){
    return nodes.size();
  }

  void norm(){
    for (int i = 0; i < nodes.size(); i++){
      Node node = nodes.get(i);
      node.norm();
    }
  }

  void calcMasses(){
    for (int i = 0; i < nodes.size(); i++){
      Node node = nodes.get(i);
      node.calcMass();
    }
  }

  void showSources(color col){
    for (int i = 0; i < nodes.size(); i++){
      Node node = nodes.get(i);
      node.showSources(col);
    }
  }
  void showNorms(color col){
    for (int i = 0; i < nodes.size(); i++){
      Node node = nodes.get(i);
      node.showNorms(col);
    }
  }
  void showMasses(color col){
    for (int i = 0; i < nodes.size(); i++){
      Node node = nodes.get(i);
      node.showMass(col);
    }
  }

  void addNodes(){
    int size = size();
    for(int i = 0; i < size; i++){
      Node node = nodes.get(i);
      PVector pos = node.pos;
      PVector mass = node.mass;
      if(!(mass.x == 0 && mass.y == 0)){
        Node newNode = new Node(pos.x + mass.x * nodeSize, pos.y + mass.y * nodeSize);
        newNode.prevNode = i;
        if (node.childNode != 0){
          newNode.level = node.level + 1;
          // float _weight = pow(pow(node.weight, exponent) - pow(nodes.get(node.childNode).weight, exponent),1.0/exponent);
          // newNode.weight = _weight; //<>//
        } else{
          node.childNode = nodes.size();
          newNode.level = node.level;
          // newNode.weight = node.weight - growth;
        }
        // newNode.weight -= newNode.level*2;
        nodes.add(newNode);
      }
    }
  }
}
