// PImage pic;
// PVector pos;
// PVector vel;
float falloff = 120;
ArrayList<Layer> layers;
// Layer baseLayer;
String baseName = "maugli_parallax_";
int depths[] = {1, 5, 7, 10, 14, 16};



void setup(){
  size(700, 700);
  layers = new ArrayList<Layer>();
  for (int i = 0; i < 6; i++){
    PImage pic = loadImage(baseName + (i+1) + ".png");
    resize(pic);
    layers.add(new Layer(pic, depths[i]));
  }
}


void draw(){
  background(0);
  for (int i = 0; i < layers.size(); i++){
    Layer layer = layers.get(i);
    layer.updatePos(new PVector(mouseX, mouseY));
    layer.display();

  }
  //noLoop();
}

// void keyPressed() {
//   if (keyCode == UP){
//     pos.y -= 50;
//   } else if (keyCode == DOWN){
//     pos.y += 50;
//   } else if (keyCode == RIGHT){
//     pos.x += 50;
//   } else if (keyCode == LEFT){
//     pos.x -= 50;
//   }
//   pos.x = constrain(pos.x, -falloff, falloff);
//   pos.y = constrain(pos.y, -falloff, falloff);
// }

void resize(PImage pic){
  int nW = pic.width;
  int nH = pic.height;
  if (nW > width){
    nW = width;
    nH = floor((nW * pic.height) / pic.width);
  }

  if(nH > height){
    nH = height;
    nW = floor((nH * pic.width) / pic.height);
  }
  pic.resize(floor(nW*1.2), floor(nH*1.2));
}
