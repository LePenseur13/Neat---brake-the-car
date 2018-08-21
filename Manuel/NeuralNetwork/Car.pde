class Car {
    float acc = 0;
    float vel = 10;
    float x;
    float y;
    float limit = 10;
    float sizeX = 13;
    float sizeY = 7;
    boolean driving = true;
    boolean stopping = false;
    boolean stopped = false;
    boolean inGoal = false;
    float fitness = 0;
    int step = 1;
    Brain brain;


    Car(int number_inputs) {
        x = 30;
        y = 400;
        brain = new Brain(number_inputs);
    }
    
    void move() {
        if (vel + acc >= 0) {
            vel += acc;
        } else {
            stopped = true;
            stopping = false;
        }
        x += vel;
        step++;
    }
    
    void show() {
        fill(255, 255, 255);
        rect(x, y, sizeX, sizeY);
    }
    
    void stop_() {
        acc = -1;
        driving = false;
        stopping = true;
    }
    
    float look(float goalX) {
        float dist = goalX - x;
        if (dist < 0) {
            dist *= -1;
        }
        return dist;
    }
    
    boolean guess(float[] inputs) {
         return brain.guess(inputs);   
    }

    Car gimmeBaby() {
        Car clone = new Car(2);
        clone.brain = brain;
        return clone;
    }

    boolean calculateFitness(float goalX, float goalLength) { //returns if the car was in the goal as (true: yes it was/ false: no it wasnt)
        if (x >= goalX && x <= goalX + goalLength) {
            fitness = 1.0 / 0.00001;
            return true;
        } else {
            float dist = goalX - x;
            if (dist < 0) {
                dist = dist * - 1;
            }
            fitness = 1.0 / (dist * 10);
            return false;
        }
        
        
    }
}
