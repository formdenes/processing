import processing.svg.*;

float s = 3.0;
int seed = 5555555;

public void settings() {
  size(floor(210*s),floor(297*s));
}

void setup(){
  noLoop();
  beginRecord(SVG, "waves.svg");
  noiseSeed(seed);
}

void draw(){
  //background(255);
  stroke(0);
  noFill();
  float d = 300;
  circle(width/2, height/2, d);
  stroke(0,0,255);
  
  float yoff = 0.0;
         // Option #1: 2D Noise
   //float xoff = yoff; // Option #2: 1D Noise
  
  // Iterate over horizontal pixels
  for (float y = 0; y <= height; y+= 10){
    
  beginShape();
  float xoff = 0;
    for (float x = 0; x <= width; x += 35) {
      // Calculate a y value according to noise, map to 
      float ydiff = map(noise(xoff, yoff), 0, 1, 0,250); // Option #1: 2D Noise
      float curry = y + ydiff;
       //float y = map(noise(xoff), 0, 1, 200,300);    // Option #2: 1D Noise
      
      // Set the vertex
        curveVertex(x, curry); 
      //vertex(x, curry);
      // Increment x dimension for noise
      xoff += 0.2;
    }
  // increment y dimension for noise
  yoff += 0.04;
  endShape(OPEN);
  }
  
  stroke(255,0,0); //RED
  yoff = 0.0;
  PVector home = new PVector(width/2,height/2);
         // Option #1: 2D Noise
   //float xoff = yoff; // Option #2: 1D Noise
  
  // Iterate over horizontal pixels
  for (float y = 0; y <= height; y+= 10){
    
  beginShape();
  
  float xoff = 0;
  boolean outside = true;
  PVector prevPos = new PVector(0,0);
    for (float x = 0; x <= width; x += 35) {
      // Calculate a y value according to noise, map to 
      float ydiff = map(noise(xoff, yoff), 0, 1, 0,250); // Option #1: 2D Noise
      float curry = y + ydiff;
       //float y = map(noise(xoff), 0, 1, 200,300);    // Option #2: 1D Noise
      
      // Set the vertex
      PVector curr = new PVector(x,curry);
      float dist = PVector.dist(home, curr);
      if ( dist <= d/2){
        if (outside){ //<>//
         prevPos.lerp(home, PVector.dist(home, prevPos)/d/2); //<>//
         curveVertex(prevPos.x, prevPos.y); 
        }
        outside = false;
        curveVertex(x, curry); 
      } else {
         if (!outside){
           prevPos.lerp(home, PVector.dist(home, curr)/d/2);
           //curveVertex(curr.x, curr.y); 
         }
         outside = true;
      }
      //if ( pow(width/2-x,2) + pow(height/2-curry,2) < pow(d/2,2)){
      //  curveVertex(x, curry); 
      //}
      //vertex(x, curry);
      // Increment x dimension for noise
      xoff += 0.2;
    }
  // increment y dimension for noise
  yoff += 0.04;
  endShape(OPEN);
  }
  
  endRecord();
}
