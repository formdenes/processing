ArrayList<PVector> sources = new ArrayList<PVector>();
ArrayList<ArrayList<Node>> fractures = new ArrayList<ArrayList<Node>>();
// ArrayList<PVector> fracture = new ArrayList<PVector>();
// ArrayList<PVector> masses;
// IntList massCounters;
int sourceSize = 1000;
int step = 20;
int FOW = 30;
int DENS = 5;


void setup() {
	size(500,500);
	ArrayList<Node> fracture1 = new ArrayList<Node>();
	// ArrayList<PVector> fracture2 = new ArrayList<PVector>();
	// ArrayList<PVector> fracture3 = new ArrayList<PVector>();
	// ArrayList<PVector> fracture4 = new ArrayList<PVector>();
	fracture1.add(new Node(width / 2, height - step));
	// fracture2.add(new PVector(width/2, FOW));
	// fracture3.add(new PVector(width-FOW, height/2));
	// fracture4.add(new PVector(FOW, height/2));
	fractures.add(fracture1);
	// fractures.add(fracture2);
	// fractures.add(fracture3);
	// fractures.add(fracture4);
	frameRate(2);
}

void draw() {
	sources = generateSources(sources, fractures);
	background(230);
	ArrayList<PVector> sourcesToRemove = new ArrayList<PVector>();
	// masses = new ArrayList<PVector>();
	// massCounters = new IntList();
	// for(int i = 0; i < fractures.size(); i++){
	//   masses.add(new PVector(0,0));
	//   massCounters.append(0);
	// }
	for (int s = 0; s < sources.size(); s++) {
		PVector source = sources.get(s);
		float minDist = sqrt(width * width + height * height);
		int minF = 0;
		int minN = 0;
		fill(255, 0, 0);
		noStroke();
		circle(source.x, source.y, 2);
		for (int f = 0; f < fractures.size(); f++) {
			ArrayList<Node> fracture = fractures.get(f);
			for (int n = 0; n < fracture.size(); n++) {
		Node node = fracture.get(n);
		float _dist = dist(node.pos.x, node.pos.y, source.x, source.y);
		if (_dist <= minDist) {
			 minDist = _dist;
			 minF = f;
			 minN = n;
			 // masses.get(f).x += source.x;
			 // masses.get(f).y += source.y;
			 // massCounters.set(f, massCounters.get(f) + 1);
			 // sources.remove(s); //<>//
				}
			}
		}
		// if(minF != null && minN != null){
		Node closestNode = fractures.get(minF).get(minN);
		closestNode.sources.add(source);
		// sourcesToRemove.add(source);
		// masses.get(minF).x += source.x;
		// masses.get(minF).y += source.y;
		// massCounters.set(minF, massCounters.get(minF) + 1);
		// sources.remove(s); //<>//
		// }
		if (minDist <= DENS) {
			sourcesToRemove.add(source);
		}
	}
	for (int i = 0; i < sourcesToRemove.size(); i++) {
		sources.remove(sourcesToRemove.get(i));
	}
	for (int i = 0; i < fractures.size(); i++) {
		ArrayList<Node> fracture = fractures.get(i);
		for (int j = 0; j < fracture.size(); j++) {
			Node node = fracture.get(j);
			node.calcMass();
			stroke(0, 0, 255);
			strokeWeight(3);
			noFill();
			// circle(node.mass.x, node.mass.y, 10);
		}
	}
	// mass.x = mass.x / massCount;
	// mass.y = mass.y / massCount;
	for (int j = 0; j < fractures.size(); j++) {
		// beginShape();
		ArrayList<Node> fracture = fractures.get(j);
		for (int i = 0; i < fracture.size(); i++) {
			Node node = fracture.get(i);
			stroke(0, 0, 0);
			circle(node.pos.x, node.pos.y, 5);
			fill(0);
			text(str(j) + " " + str(i), node.pos.x, node.pos.y);
			strokeWeight(3);
			noFill();
			if (i >= 1) {
	    	line(node.pos.x, node.pos.y, fracture.get(i - 1).pos.x, fracture.get(i - 1).pos.y);
			}
			// circle(node.x, node.y, step);
			// vertex(node.pos.x, node.pos.y);
			if (i == fracture.size() - 1) {
        // circle(node.pos.x, node.pos.y, FOW * 2);
        strokeWeight(1);
        float xdist = node.mass.x - node.pos.x;
        float ydist = node.mass.y - node.pos.y;
        float nxdist = xdist / sqrt(xdist * xdist + ydist * ydist) * step;
        float nydist = ydist / sqrt(xdist * xdist + ydist * ydist) * step;
        // println(nxdist, nydist);
        Node nNode = new Node(floor(node.pos.x + nxdist), floor(node.pos.y + nydist)); //<>//
        fracture.add(nNode); //<>//
        break; //<>//
			} else if (!(node.mass.x == 0 && node.mass.y == 0)) {
        float xdist = node.mass.x - node.pos.x;
        float ydist = node.mass.y - node.pos.y;
        float nxdist = xdist / sqrt(xdist * xdist + ydist * ydist) * step;
        float nydist = ydist / sqrt(xdist * xdist + ydist * ydist) * step;
        ArrayList<Node> nFracture = new ArrayList<Node>();
        Node nNode = new Node(floor(node.pos.x + nxdist), floor(node.pos.y + nydist));
        nFracture.add(nNode);
        fractures.add(nFracture);
			}
		}
		// endShape(OPEN); //<>//
	}
	println(frameRate); //<>//
	// noLoop(); //<>//
}


ArrayList<PVector> generateSources(ArrayList<PVector> sources, ArrayList<ArrayList<Node>> fractures) {
	for (int n = 0; n < sourceSize; n++) {
		PVector source = new PVector(random(0, width), random(0, height));
		boolean free = true;
		for (int i = 0; i < sources.size() && free; i++) {
			float _dist = dist(source.x, source.y, sources.get(i).x, sources.get(i).y);
			if (_dist <= DENS) {
		free = false;
		break;
			}
		}
		for (int i = 0; i < fractures.size() && free; i++) {
			ArrayList<Node> fracture = fractures.get(i);
			for (int j = 0; j < fracture.size() && free; j++) {
		float _dist = dist(source.x, source.y, fracture.get(j).pos.x, fracture.get(j).pos.y);
		if (_dist <= DENS) {
			 free = false;
			 break;
				}
			}
			if (!free) {break;}
		}
		if (free) {
			sources.add(source);
		}
	}
	return sources;
}
