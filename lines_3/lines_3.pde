int len = 50;
void setup(){
  size(500, 500, P2D);
  smooth(8);
}

void draw(){
  background(255);
  for(int i = 0; i < width/len; i++){
    for(int j = 0; j < height/len; j++){
      int dir = round(random(1));
      strokeWeight(4);
      stroke(0);
      noFill();
      line((i*len)+(dir*len), j*len, ((i+1)*len)-(dir*len), (j+1)*len);
    }
  }
  noLoop();
}
