import processing.svg.*;

float s = 3.0;

public void settings() {
  size(floor(210*s),floor(297*s));
}

void setup(){
  noLoop();
  beginRecord(SVG, "example.svg");
}

void draw(){
  //background(255);
  int unit = 20;
  for (int i = 0; i < floor(width/unit); i++){
    for (int j = 0; j < floor(height/unit); j++){
      if (round(random(1)) == 1){
        line(i*unit, j*unit, (i+1)*unit, (j+1)*unit);
      } else {
        line((i+1)*unit, j*unit, i*unit, (j+1)*unit);
      }
      
    } 
  }
  
  endRecord();
}
