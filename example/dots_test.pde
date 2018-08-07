Population test;
PVector goal = new PVector(400, 100);


void setup() {
    size(800, 800); //size of the window
    frameRate(500);//increase this to make the dots go faster
    test = new Population(100);
}

void draw() { 
    background(255);
    
    //draw goal
    fill(255, 0, 0);
    ellipse(goal.x, goal.y, 10, 10);
    
    //draw obstacle
    //fill(0, 0, 255);

    //rect(0, 300, 600, 10); 
    
    
    if (test.allDotsDead()) {
         test.calculateFitness();
         test.naturalSelection();
         test.mutateDemBabies();
    } else {
        test.update();
        test.show();
    }
    
}
