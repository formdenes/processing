// Interpolant inter;
// color[] colors;
// color randomColor;
PGraphics pg;
ArrayList<Line> lines;

void setup(){
  size(500,1000, P2D);
  smooth(8);
  pg = createGraphics(500,1000, P2D);
  pg.smooth(8);
  lines = new ArrayList<Line>();
  lines.add(new Line(20, 0, 20, height, color(0), 3, pg));
  lines.add(new Line(40, 0, 40, height, color(0), 3, pg));
  lines.add(new Line(60, 0, 60, height, color(0), 3, pg));
  ArrayList<PVector> points = new ArrayList<PVector>();
  for(int i = 0; i < 10; i++){
    points.add(new PVector(80, i*100));
    points.add(new PVector(500, i*100));
  }
  lines.add(new Line(points, color(0), 3, pg));
  // randomColor = color(random(255), random(255), random(255));
  // colors = getNiceColors(randomColor);
  // println(colors);
	// inter = new Interpolant((float) height - 50, colors, false);
	
}

void draw(){
  pg.beginDraw();
  background(255);

  lines.get(0).betterLine();
  lines.get(1).handLine();
  lines.get(2).handLineWidth();
  lines.get(3).handLine();
  // betterLine(20, 0, 20, height, color(0), 3, pg);
  // handLine(40, 0, 40, height, color(0), 3, pg);
  // handLine(60, 0, 60, height, color(0), 3, pg);

  pg.endDraw();
  image(pg, 0,0, width, height);
  // handLine(40, 0, 40, height, color(0), 3, pg);
  // noStroke();
  // fill(randomColor);
  // rect(width/2, 0, 20, height);
  // rect((width / 2) - 10, 0, 20, height);
  // // translate(0, 50);
  // for(int i = 0; i < colors.length; i ++){
  //   color col = colors[i];
  //   fill(col);
  //   rect(0, i * (height - 50) / 6, width/2 - 10, (i + 1) * (height - 50) / 6);
  // }
  // loadPixels();
  // for(int x = 0; x < width; x++){
  //   for(int y = 0; y < height; y++){
  //     if(x > width/2+10){
  //       pixels[x + y * width] = inter.getGradientMonotonCubic(y, 255);
  //     }
  //   }
  // }
  // updatePixels();
  // noLoop();
}


class Interpolant {
  
  int[] xs, rs, gs, bs;
  
  float[] c1rs, c1gs, c1bs;
  
  float[] c2rs, c3rs, c2gs, c3gs, c2bs, c3bs;
  
  Interpolant(float range, color[] points, boolean loop) {
    // Deal with length issues
    int size = points.length, section;
    
    // if (size == 0) { return color(0); }
    //if (length === 1) {
    //  // Impl: Precomputing the result prevents problems if ys is mutated later and allows garbage collection of ys
    //  // Impl: Unary plus properly converts values to numbers
    //  var result = +ys[0];
    //  return function(x) { return result; };
    //}
    if (loop) {
      xs = new int[size + 1];
      rs = new int[size + 1];
      gs = new int[size + 1];
      bs = new int[size + 1];
      section = floor(range / (size));
    }
    else {
      xs = new int[size];
      rs = new int[size];
      gs = new int[size];
      bs = new int[size];
      section = floor(range / (size - 1));
    }
    for (int i = 0; i < xs.length; i++) {
      xs[i] = i * section;
      rs[i] = floor(red(points[i % size]));
      gs[i] = floor(green(points[i % size]));
      bs[i] = floor(blue(points[i % size]));
    }
    size = xs.length;
    // Rearrange xs and ys so that xs is sorted
    //var indexes = [];
    //for (i = 0; i < length; i++) { indexes.push(i); }
    //indexes.sort(function(a, b) { return xs[a] < xs[b] ? -1 : 1; });
    //var oldXs = xs, oldYs = ys;
    //// Impl: Creating new arrays also prevents problems if the input arrays are mutated later
    //xs = []; ys = [];
    //// Impl: Unary plus properly converts values to numbers
    //for (i = 0; i < length; i++) { xs.push(+oldXs[indexes[i]]); ys.push(+oldYs[indexes[i]]); }
    
    
    
    // Get consecutive differences and slopes
    float[] drs = new float[size], dgs = new float[size], dbs = new float[size], dxs = new float[size], mrs = new float[size], mgs = new float[size], mbs = new float[size]; 
    for (int i = 0; i < xs.length - 1; i++) {
      float dx = xs[i + 1] - xs[i];
      float dr = rs[i + 1] - rs[i], dg = gs[i + 1] - gs[i], db = bs[i + 1] - bs[i];
      dxs[i] = dx;
      drs[i] = dr;
      dgs[i] = dg;
      dbs[i] = db;
      mrs[i] = dr / dx;
      mgs[i] = dg / dx;
      mbs[i] = db / dx;
    }
    
    // Get degree-1 coefficients
  c1rs = new float[dxs.length];
  c1gs = new float[dxs.length];
  c1bs = new float[dxs.length];
    c1rs[0] = mrs[0];
    c1gs[0] = mgs[0];
    c1bs[0] = mbs[0];
    for (int i = 0; i < dxs.length - 1; i++) {
      float mr = mrs[i], mrNext = mrs[i + 1];
      float mg = mgs[i], mgNext = mgs[i + 1];
      float mb = mbs[i], mbNext = mbs[i + 1];
      float dx_ = dxs[i], dxNext = dxs[i + 1], common = dx_ + dxNext;
      if (mr * mrNext <= 0) {
        c1rs[i] = 0;
      } else {
        c1rs[i] = 3 * common / ((common + dxNext) / mr + (common + dx_) / mrNext);
      }
      if (mg * mgNext <= 0) {
        c1rs[i] = 0;
      } else {
        c1rs[i] = 3 * common / ((common + dxNext) / mg + (common + dx_) / mgNext);
      }
      if (mb * mbNext <= 0) {
        c1rs[i] = 0;
      } else {
        c1rs[i] = 3 * common / ((common + dxNext) / mb + (common + dx_) / mbNext);
      }
    }
    c1rs[dxs.length - 1] = mrs[mrs.length - 1];
    c1gs[dxs.length - 1] = mgs[mgs.length - 1];
    c1bs[dxs.length - 1] = mbs[mbs.length - 1];
    
    // Get degree-2 and degree-3 coefficients
  
    c2rs = new float[c1rs.length - 1];
  c3rs = new float[c1rs.length - 1];
    c2gs = new float[c1gs.length - 1];
  c3gs = new float[c1gs.length - 1];
    c2bs = new float[c1bs.length - 1];
  c3bs = new float[c1bs.length - 1];
    for (int i = 0; i < c1rs.length - 1; i++) {
      float c1r = c1rs[i], mr_ = mrs[i], invDx = 1 / dxs[i], commonr_ = c1r + c1rs[i + 1] - mr_ - mr_;
      float c1g = c1gs[i], mg_ = mgs[i], commong_ = c1g + c1gs[i + 1] - mg_ - mg_;
      float c1b = c1bs[i], mb_ = mbs[i], commonb_ = c1b + c1bs[i + 1] - mb_ - mb_;
      c2rs[i] = (mr_ - c1r - commonr_) * invDx; c3rs[i] = commonr_ * invDx * invDx;
      c2gs[i] = (mg_ - c1g - commong_) * invDx; c3gs[i] = commong_ * invDx * invDx;
      c2bs[i] = (mb_ - c1b - commonb_) * invDx; c3bs[i] = commonb_ * invDx * invDx;
    }
  }
  
  color getGradientMonotonCubic(float loc, int alpha) {
    int i = xs.length - 1;
    if ((float) loc == xs[i]) {return color(rs[i], gs[i], bs[i]);}
    
    // Search for the interval x is in, returning the corresponding y if x is one of the original xs
    int low = 0, mid, high = c3rs.length - 1;
    while(low <= high) {
      mid = floor(0.5 * (low + high));
      float xHere = xs[mid];
      if (xHere < loc) { low = mid + 1; }
      else if (xHere > loc) { high = mid - 1; }
      else { return color(rs[mid], gs[mid], bs[mid]); }
    }
    i = max(0, high);
    
    // Interpolate
    float diff = loc - xs[i], diffSq = diff * diff;
    float red = rs[i] + c1rs[i] * diff + c2rs[i] * diffSq + c3rs[i] * diff * diffSq;
    float green = gs[i] + c1gs[i] * diff + c2gs[i] * diffSq + c3gs[i] * diff * diffSq;
    float blue = bs[i] + c1bs[i] * diff + c2bs[i] * diffSq + c3bs[i] * diff * diffSq;
    return color(red, green, blue, (float) alpha);
  }
}

color[] getNiceColors(color col){
  return getNiceColors(col, 6);
}

color[] getNiceColors(color col, int num){
  String hex = hex(col, 6);
  String url = "https://www.thecolorapi.com/scheme?hex=" + hex + "&mode=analogic&count=" + String.valueOf(num) + "&format=json";
  // println(url);
  JSONObject json = loadJSONObject(url);
  color[] colors = new color[num];
  for (int i = 0; i < colors.length; i++){
    colors[i] = unhex("FF" + json.getJSONArray("colors").getJSONObject(i).getJSONObject("hex").getString("clean"));
  }
  return colors;
}
