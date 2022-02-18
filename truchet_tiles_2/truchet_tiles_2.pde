float len = 20;
// int frac = 5;
// int dens = 5;

void setup(){
  size(1000, 1000, P2D);
  smooth(8);
}

void draw(){
  background(255);
  strokeWeight(2);
  stroke(0);
  noFill();
  for(int i = 0; i < width/len; i++){
    for(int j = 0; j < height/len; j++){
      // for(int k = 0; k < dens; k++){
        int dir = floor(random(5));
        switch (dir) {
          case 0:
            arc((i+0.5)*len, (j)*len, 1*len/3, 1*len/3, 0, PI);
            arc((i+0.5)*len, (j+1)*len, 1*len/3, 1*len/3, PI, PI+PI);
            line(i*len, (j+1.0/3)*len, (i+1)*len, (j+1.0/3)*len);
            line(i*len, (j+2.0/3)*len, (i+1)*len, (j+2.0/3)*len);
            break;
          case 1:
            arc((i)*len, (j+0.5)*len, 1*len/3, 1*len/3, -HALF_PI, HALF_PI);
            arc((i+1)*len, (j+0.5)*len, 1*len/3, 1*len/3, HALF_PI, PI+HALF_PI);
            line((i+1.0/3)*len, j*len, (i+1.0/3)*len, (j+1)*len);
            line((i+2.0/3)*len, j*len, (i+2.0/3)*len, (j+1)*len);
            break;
          case 2:
            arc((i+1)*len, j*len, 2*len/3, 2*len/3, HALF_PI, PI);
            arc((i+1)*len, j*len, 4*len/3, 4*len/3, HALF_PI, PI);
            arc(i*len, (j+1)*len, 4*len/3, 4*len/3, -HALF_PI, 0);
            arc(i*len, (j+1)*len, 2*len/3, 2*len/3, -HALF_PI, 0);
            break;
          case 3:
            arc(i*len, j*len, 2*len/3, 2*len/3, 0, HALF_PI);
            arc(i*len, j*len, 4*len/3, 4*len/3, 0, HALF_PI);
            arc((i+1)*len, (j+1)*len, 4*len/3, 4*len/3, -PI, -HALF_PI);
            arc((i+1)*len, (j+1)*len, 2*len/3, 2*len/3, -PI, -HALF_PI);
            break;
          case 4:
            arc(i*len, j*len, 2*len/3, 2*len/3, 0, HALF_PI);
            arc((i+1)*len, j*len, 2*len/3, 2*len/3, HALF_PI, PI);
            arc(i*len, (j+1)*len, 2*len/3, 2*len/3, -HALF_PI, 0);
            arc((i+1)*len, (j+1)*len, 2*len/3, 2*len/3, -PI, -HALF_PI);
            break;
        }
    }
  }
  noLoop();
}

void keyReleased() {
  if (key == 'r') {
    redraw();
  }
}
