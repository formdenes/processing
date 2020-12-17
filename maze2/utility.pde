void betterLine(float x, float y, float xx, float yy, color col, float s, PGraphics g){
	betterLine(x, y, xx, yy, col, s, g, 6);
}

void betterLine(float x, float y, float xx, float yy, color col, float s, PGraphics g, int rep){
	g.noFill();
  g.strokeCap(ROUND);
	g.stroke(col);
	g.strokeWeight(s);
	g.line(x, y, xx, yy);
  g.stroke(col, 10);
	for(int n = 0; n < rep; n++){
		g.strokeWeight(s*pow(1.1, n));
		g.line(x, y, xx, yy);
	}
}

void save(String name, PGraphics pg, float w, float h){
	println("Saving...");
	String picName = "pictures/" + name + ".png";
	PGraphics art = createGraphics(floor(w), floor(h), P2D);
	art.image(pg, 0, 0, w, h);
	art.save(picName);
	println("picture saved as: ", picName);
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
