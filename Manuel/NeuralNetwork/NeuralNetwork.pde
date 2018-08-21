Population p;
boolean toggle = false;
float goalX = 500;
float goalLength = 100;
float[] inputs = new float[2];

void setup() {
    size(640, 480);
    p = new Population(1000, 2);
    frameRate(120);
}

void draw() {
    background(255);
    //goal
    fill(0, 255, 0);
    rect(goalX, 350, 60, goalLength);
    //street
    fill(0, 50, 100);
    rect(30, 350, 470, 100);
    if (p.allDead()) {
        p.calculateFitness(goalX, goalLength);
        p.naturalSelection();
        p.mutateDemBabies();
    } else {
        p.update(goalX);
    }
    //range of right values: (360-419);
}
