int len = 50;
// int frac = 5;
// int dens = 5;

void setup(){
  size(800, 800, P2D);
  smooth(8);
}

void draw(){
  background(255);
  for(int i = 0; i < width/len; i++){
    for(int j = 0; j < height/len; j++){
      // for(int k = 0; k < dens; k++){
        int dir = floor(random(2));
        // float x1 = (1-dir)*1/float(frac+1)*floor(random(frac+1));
        // float x2 = (1-dir)*1/float(frac+1)*floor(random(frac+1));
        // float y1 = dir*1/float(frac+1)*floor(random(frac+1));
        // float y2 = dir*1/float(frac+1)*floor(random(frac+1));
        println(dir);
         strokeWeight(4);
         stroke(0);
         noFill();
        // rect(i*len,j*len, len, len);
        // line((i*len)+(x1*len), j*len+(y1*len), ((i+1)*len)-(x2*len), (j+1)*len-(y2*len));
        // arc((i)*len, j*len, len, len, 0, HALF_PI);
        arc((i+dir)*len, j*len, len, len, dir*(HALF_PI),(dir+1)*HALF_PI);
        arc((i+(1-dir))*len, (j+1)*len, len, len, PI+dir*(HALF_PI),PI+(dir+1)*HALF_PI);
      // }
    }
  }
  noLoop();
}

void keyReleased() {
  if (key == 'r') {
    redraw();
  }
}
