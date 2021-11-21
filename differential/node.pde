class Node{
  public PVector pos;
  public PVector attr;
  public PVector rej;
  public float step;
  public float curv = 1;

  Node(PVector p){
    this.pos = p;
    this.attr = new PVector(0,0);
    this.rej = new PVector(0,0);
    this.step = .002;
  }

  public void addAttr(PVector v){
    // v.normalize();
    attr.add(v);
  }

  public void nullAttr(){
    attr.set(0,0);
  }

  public void displayAttr(){
    noFill();
    stroke(0, 250, 0);
    line(pos.x, pos.y, pos.x+attr.x, pos.y+attr.y);
  }

  public void nullRej(){
    rej.set(0,0);
  }

  public void addRej(PVector v){
    rej.add(v);
  }

  public void displayRej(){
    noFill();
    stroke(250, 0, 0);
    line(pos.x, pos.y, pos.x+rej.x, pos.y+rej.y);
  }

  public void step(){
    PVector dir = PVector.add(attr, rej);
    // float magn = dir.mag();
    dir.mult(step);
    // noFill();
    // stroke(0, 0, 250);
    // line(pos.x, pos.y, pos.x+dir.x, pos.y+dir.y);
    pos.add(dir);
  }

  public void display(){
    fill(0,0,0,200);
    noStroke();
    circle(pos.x, pos.y, 3);
    fill(0,0,200,255*curv);
    // circle(pos.x, pos.y, 10*curv);
  }

  public void setCurve(float c){
    curv = c;
  }
}
