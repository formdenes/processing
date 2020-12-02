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
    for (int n = 0; n < dartThrows; n++) {
      PVector source = new PVector(random(0, width), random(0, height));
      boolean free = true;
      for (int i = 0; i < sources.size() && free; i++) {
        float _dist = dist(source.x, source.y, sources.get(i).x, sources.get(i).y);
        if (_dist <= DENS) {
          free = false;
          break;
        }
      }
      for (int j = 0; j < vein.nodes.size() && free; j++) {
        float _dist = dist(source.x, source.y, vein.getNode(j).pos.x, vein.getNode(j).pos.y);
        if (_dist <= DENS) {
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
        if (_dist <= DENS) {
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
