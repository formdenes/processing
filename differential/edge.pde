class Edge{
  public Node node1;
  public Node node2;

  Edge(Node n1, Node n2){
    this.node1 = n1;
    this.node2 = n2;
  }

  public void display(){
    noFill();
    stroke(0,0,0,100);
    strokeWeight(2);
    line(node1.pos.x, node1.pos.y, node2.pos.x, node2.pos.y);
  }
  public void display(int index){
    noFill();
    strokeWeight(index/10);
    stroke(0,0,0,100);
    line(node1.pos.x, node1.pos.y, node2.pos.x, node2.pos.y);
  }

  public void addAttr(float idealDist){
    PVector attr1 = PVector.sub(node2.pos, node1.pos);
    PVector attr2 = PVector.sub(node1.pos, node2.pos);
    // if (attr1.mag() - idealDist < 0){
    //   // println("Attr1:", attr1, "Mag:", attr1.mag(), 
    //     // "Mag - idealDist:", attr1.setMag(null, attr1.mag()-idealDist),
    //     // "NewMag:", attr1.setMag(null, attr1.mag()-idealDist).mag());
    // }
    attr1.setMag((attr1.mag()-idealDist));
    attr2.setMag((attr2.mag()-idealDist));
    node1.addAttr(attr1);
    node2.addAttr(attr2);
  }

  public void split(Node n){
    node2 = n;
  }

  public PVector getDir(){
    PVector dir = new PVector();
    dir = PVector.sub(node2.pos, node1.pos);
    return dir;
  }
}
