class Node {
  PVector pos;
  PVector mass;
  ArrayList<PVector> norms;
  ArrayList<PVector> sources;
  Node prevNode;
  Node nextNode;

  Node(float x, float y){
    pos = new PVector(x, y);
    mass = new PVector();
    sources = new ArrayList<PVector>();
    norms = new ArrayList<PVector>();
  }

  void show(color col, float size){
    noStroke();
    fill(col);
    circle(pos.x, pos.y, 3);
    for (PVector source : sources){
      fill(0, 0, 240);
      circle(source.x, source.y, 2); //<>// //<>//
    }
    noFill();
    stroke(col);
    circle(pos.x, pos.y, size * 2);
  }

  void norm(){
    norms = new ArrayList<PVector>();
    for (PVector source : sources){
      PVector _vec = new PVector(source.x - pos.x, source.y - pos.y);
      _vec.normalize();
      norms.add(_vec);
    }
  }

  void showNorms() {
    for (PVector norm : norms){
      stroke(0, 240, 0);
      noFill();
      line(pos.x,  pos.y, pos.x + norm.x * STEP, pos.y + norm.y * STEP);
    }
  }

  ArrayList<PVector> calcMass(){
    ArrayList<PVector> sourcesToRemove = new ArrayList<PVector>();
    if(sources.size() > 0){
      mass = new PVector(0,0);
      for(PVector norm : norms){
        mass.add(norm);
      }
      mass.normalize();
      sourcesToRemove.addAll(sources);
    }
    else{
      norms = new ArrayList<PVector>();
      mass = new PVector();
    }
    return sourcesToRemove;
  }

  void showMass(){
    stroke(20, 20, 220);
    line(pos.x, pos.y, pos.x + mass.x * STEP, pos.y + mass.y * STEP);
  }
}
