PImage car;
PImage road;
final int XMARGIN = 2;
final int YMARGIN = 2;

float xCar;
float yCar;

float v0;
float v1;

int targetX;
int targetSize;


final int BRAKING_FORCE = 7000; // N
final int CAR_MASS = 1200; // kg
//float acc;
float t;
boolean braking;

final int FRAME_RATE = 30;
final int FRAMES_PER_SEC = 30;

// scale: 80px = 4m -> 20px = 1m
final int PX_EQ_1M = 20;
// car size x: 70; y: 40
final int CAR_SIZE = 80;

void setup() {
    size(1200, 300, P2D); //size of the window
    frameRate(FRAME_RATE);//increase this to make the dots go faster
    car = loadImage("car-icon-small2.png");
    road = loadImage("road.jpg");
    
    xCar = XMARGIN;
    yCar = height - car.height - YMARGIN;
    
    targetX = 1000;
    targetSize = 100;

    v0 = 5 * PX_EQ_1M;
    v1 = v0;
    t = 0;
    braking = false;
}

void draw() { 
    background(255);
    image(road, 0, height - 100);    
    image(car, xCar - CAR_SIZE, yCar); 
    
    fill(#000000);
    text("Velocity: " + String.valueOf(String.format("%.02f", v1 / PX_EQ_1M)) + "m/s", XMARGIN, 100);
    text("Distance to Target: " + String.valueOf(String.format("%.02f", Math.abs(targetX - xCar) / PX_EQ_1M)) + "m", XMARGIN, 130);
     //<>//
    //stroke(#FF0000);
    fill(#FF0000);
    ellipse(xCar-2, height - 10 -2, 4, 4);
    ellipse(xCar - CAR_SIZE, height - 10 -2, 4, 4);
    ellipse(targetX-2, height - 10-2, 4, 4);

    // stroke(#0000FF);
    //line(400, height - car.height, 400, height - MARGIN);
    //line(500, height - car.height, 500, height - MARGIN);

    noStroke();
    fill(#00FF00, 92);
    rect(targetX - targetSize, height - 44, targetSize, 42);
    move();
    
}

void move() {
    if(braking) {
        v1 = v0 - (BRAKING_FORCE / CAR_MASS) * t;
        if(v1 > 0) {
            xCar += v1 / FRAMES_PER_SEC;
            t += 1 / (float)FRAMES_PER_SEC;
        } else {
            v1 = 0; 
            gameEnd();
        }
    } else {
        xCar += v1 / FRAMES_PER_SEC;
    }
}

void keyPressed() {
    braking = true;
}

void gameEnd() {
     // victory banner
     // timeout for exit
}
