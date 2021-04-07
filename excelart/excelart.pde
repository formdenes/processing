String name = "432";
// int w = 100;
// int h = 52;
PImage img;
IntList colors;

PrintWriter output;

void setup(){
  size(100,52);
  img = loadImage(name+".bmp");
  colors = new IntList();
  output = createWriter(name+".txt");
}

void draw(){
  image(img,0,0);
  loadPixels();
  IntList cells = new IntList();

  // for(int i = 0; i < width*height; i++){
  //   color col = pixels[i];
  //   colors.append(col);
  // }


  for(int i = 0; i < width*height; i++){
    color col = pixels[i];
    if(!colors.hasValue(col)){
      colors.append(col);
    }
  }

  colors.sort();
  int[] colArr = colors.array();
  println(colArr);

  for(int i = 0; i < width*height; i++){
    color col = pixels[i];
    // println("int value", col);
    // println("Check if contains", java.util.Arrays.asList(colArr).contains(col));
    // println("index",java.util.Arrays.asList(colArr).indexOf(col));
    // println("binary search: ", java.util.Arrays.binarySearch(colArr, col));
    cells.append((java.util.Arrays.binarySearch(colArr, col))+1); //<>//
  }

  String excelStr = "";

  for (int i = 0; i < cells.size(); i++){
    int value = cells.get(i);
    String delimiter = "";
    if((i+1)%width == 0){
      delimiter = "\t\r\n";
    } else {delimiter = "\t";}
    excelStr = excelStr + value + delimiter;
  }

  for(int i = 0; i < colArr.length; i++){
    color c = colArr[i];
    output.println((i+1) + ": HEX( " + hex(c, 6)+" )");
  }


  println(excelStr);
  println(cells.size());
  output.println(excelStr);
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  noLoop();
  exit();
}


// class ColorContainer {

// color col1=color(0);

// ColorContainer(color c_) {
//    col1=c_;
// } // the constructor

// } // the class 
