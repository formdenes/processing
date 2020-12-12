class Node {
  PVector pos;
  PVector mass;
  ArrayList<PVector> norms;
  ArrayList<Sources> sources;
  Node prevNode;
  Node nextNode;
  boolean terminated;

  Node(float x, float y){
    pos = new PVector(x, y);
    mass = new PVector();
    terminated = false;
    sources = new ArrayList<Sources>();
    norms = new ArrayList<PVector>();
  }
}