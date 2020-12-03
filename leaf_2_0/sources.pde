class Sources {
  ArrayList<PVector> sources;
  int dartThrows;

  Sources(int drtThrws) {
    dartThrows = drtThrws;
    sources = new ArrayList<PVector>();
	}

  int size(){
    return sources.size();
  }

  void findNearestNodes(Vein vein){
    for (int i = 0; i < sources.size(); i++){
      PVector source = sources.get(i);
      float minDist = sqrt(width * width + height * height);
      int minN = 0;
      for (int n = 0; n < vein.size(); n++) {
        Node node = vein.getNode(n);
        float _dist = dist(node.pos.x, node.pos.y, source.x, source.y);
        if (_dist <= minDist) {
          minDist = _dist;
          minN = n;
        }
      }
      Node closestNode = vein.getNode(minN);
      closestNode.sources.add(source);
    }
  }

  void generate(Vein vein){
    PVector[] vertices = new PVector[4];
    vertices[0] = new PVector(0,0);
    vertices[1] = new PVector(width, 0);
    vertices[2] = new PVector(width, height);
    vertices[3] = new PVector(0, height);
    // noFill();
    // stroke(255, 0, 0);
    // beginShape();
    // vertex(vertices[0].x,vertices[0].y);
    // vertex(vertices[1].x,vertices[1].y);
    // vertex(vertices[2].x,vertices[2].y);
    // vertex(vertices[3].x,vertices[3].y);
    // endShape(CLOSE);
    generate(vein, vertices);
  }

  void generate(Vein vein, PVector[] vertices){
    for (int n = 0; n < dartThrows; n++) {
      PVector source = new PVector(random(0, width), random(0, height));
      boolean free = true;
      int next = 0;
      fill(94, 204, 69);
      stroke(198, 255, 191);
      beginShape();
      for (int current=0; current<vertices.length; current++) {
        // get next vertex in list
        // if we've hit the end, wrap around to 0
        next = current+1;
        if (next == vertices.length) next = 0;

        // get the PVectors at our current position
        // this makes our if statement a little cleaner
        PVector vc = vertices[current];    // c for "current"
        PVector vn = vertices[next];       // n for "next"

        // compare position, flip 'collision' variable
        // back and forth
        if (((vc.y >= source.y && vn.y < source.y) || (vc.y < source.y && vn.y >= source.y)) &&
            (source.x < (vn.x-vc.x)*(source.y-vc.y) / (vn.y-vc.y)+vc.x)) {
                free = !free;
        }
        
        vertex(vc.x, vc.y);
      }
      endShape(CLOSE);
      free = !free;
      for (int i = 0; i < sources.size() && free; i++) {
        float _dist = dist(source.x, source.y, sources.get(i).x, sources.get(i).y);
        if (_dist <= BIRTHDIST) {
          free = false;
          break;
        }
      }
      for (int j = 0; j < vein.nodes.size() && free; j++) {
        float _dist = dist(source.x, source.y, vein.getNode(j).pos.x, vein.getNode(j).pos.y);
        if (_dist <= BIRTHDIST) {
          free = false;
          break;
          }
        }
      if (!free) {break;}
      if (free) {
        sources.add(source);
      }
    }
  }

  void removeSources(Vein vein){
    ArrayList<PVector> sourcesToRemove = new ArrayList<PVector>();
    for (int s = 0; s < sources.size(); s++){
      PVector source = sources.get(s);
      boolean free = true;
      for (int j = 0; j < vein.nodes.size() && free; j++) {
        float _dist = dist(source.x, source.y, vein.getNode(j).pos.x, vein.getNode(j).pos.y);
        if (_dist <= KILLDIST) {
          free = false;
          break;
          }
        }
      if (!free) {sourcesToRemove.add(source);}
    }
    for (int i = 0; i < sourcesToRemove.size(); i++) {
		sources.remove(sourcesToRemove.get(i));
	}
  }

  void show(color col, float size) {
    for (int i = 0; i < sources.size(); i++){
      PVector source = sources.get(i);
      fill(col);
      noStroke();
      circle(source.x, source.y, size);
    }
  }
}
