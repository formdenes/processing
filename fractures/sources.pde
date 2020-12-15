class Sources {
  ArrayList<PVector> sources;

  Sources(){
    sources = new ArrayList<PVector>();
  }

  void generate(int limit){
    while(sources.size() < limit){
      PVector _source = new PVector(random(width), random(height));
      sources.add(_source);
    }
  }
  void show(color col, float size){
    for (PVector s : sources){
      noStroke();
      fill(col);
      ellipse(s.x, s.y, size, size);
    }
  }

  void findNearestNodes(ArrayList<Fracture> fractures){
    for (PVector source : sources){
      for(Fracture fracture : fractures){
          Node node = fracture.endNode;
          node.sources = new ArrayList<PVector>();
          float _dist = dist(node.pos.x, node.pos.y, source.x, source.y);
          if (_dist <= fracture.fov){
            node.sources.add(source);
          }
      }
    }
  }
  
  void removeSources(ArrayList<PVector> sourcesToRemove){
    for(PVector source : sourcesToRemove){
      sources.remove(source);
    }
  }
}
