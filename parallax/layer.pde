class Layer{
  PVector pos;
  PImage pic;
  float depth;
  PVector origin;

  Layer(PImage pic, float depth){
    this.pic = pic;
    this.depth = depth/50;
    this.origin = new PVector(width/2, height/2);
  }

  void display(){
    PVector actPos = PVector.add(origin, PVector.sub(pos, origin).mult(depth));
    pushMatrix();
    translate(-pic.width/2, -pic.height/2);
    image(pic, actPos.x, actPos.y);
    popMatrix();
  }

  void updatePos(PVector newPos){
    pos = newPos;
  }

}