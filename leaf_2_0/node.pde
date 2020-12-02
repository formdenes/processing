class Node {
	PVector pos;
	PVector mass;
	ArrayList<PVector> sources;
  ArrayList<PVector> norms;
  int prevNode;
  int childNode;
  float weight;
  int level;
	
	Node(float x, float y) {
		pos = new PVector(x,y);
		mass = new PVector();
		sources = new ArrayList<PVector>();
		norms = new ArrayList<PVector>();
    prevNode = 0;
    childNode = 0;
    level = 0;
    weight = startWidth;
	}

  void norm(){
    norms = new ArrayList<PVector>();
    for (int i = 0; i < sources.size(); i++){
      PVector source = sources.get(i);
      PVector vec = new PVector(source.x - pos.x, source.y - pos.y);
      vec.normalize();
      norms.add(vec);
    }
  }
	
	void calcMass() {
		if (sources.size() > 0) {
			mass = new PVector(0,0);
			for (int i = 0; i < norms.size(); i++) {
				mass.add(norms.get(i));
			}
			mass.normalize();
			sources = new ArrayList<PVector>();
		}
    else {
      norms = new ArrayList<PVector>();
      mass = new PVector();
    }
	}
  void show(color col, float size) {
    fill(col);
    circle(pos.x, pos.y, size);
  }
  
  void showSources(color col){
    for (int i = 0; i < sources.size(); i++){
      stroke(col);
      line(pos.x, pos.y, sources.get(i).x, sources.get(i).y);
    }
  }

  void showNorms(color col) {
    for (int i = 0; i < norms.size(); i++){
      stroke(col);
      line(pos.x, pos.y, pos.x + norms.get(i).x * nodeSize, pos.y + norms.get(i).y * nodeSize);
    }
  }
  void showMass(color col){
    stroke(col);
    line(pos.x, pos.y, pos.x + mass.x * nodeSize, pos.y + mass.y * nodeSize);
  }
}
