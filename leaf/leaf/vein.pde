class Node {
	PVector pos;
	PVector mass;
	ArrayList<PVector> sources;
	
	Node(int x, int y) {
		pos = new PVector(x,y);
		mass = new PVector();
		sources = new ArrayList<PVector>();
	}
	
	void calcMass() {
		if sources.size() > 0 {
			mass = new PVector(0,0);
			for (int i = 0; i < sources.size(); i++) {
				PVector source = sources.get(i);
				mass.x += source.x;
				mass.y += source.y;
			}
			mass.x = mass.x / sources.size();
			mass.y = mass.y / sources.size();
			sources = new ArrayList<PVector>();
		}
	}
}