class Population {
    Car[] cars;
    float fitnessSum = 0;
    int gen = 1;
    int number_Cars;
    int number_inputs;
    int bestCar;
    int inGoal = 0;

    Population(int number_Cars_, int number_inputs_) {
        cars = new Car[number_Cars_];
        number_Cars = number_Cars_;
        number_inputs = number_inputs_;
        for (int i = 0; i < cars.length; i++) {
            cars[i] = new Car(number_inputs_);
        }
    }
    void update(float goalX) {
        float[] inputs = new float[2];
        int counter = 0;
        for (Car c : cars) {
            if (c.driving) {
                c.show();
                c.move();
                inputs[0] = c.look(goalX);
                inputs[1] = c.vel;
                if (c.guess(inputs)) {
                    c.stop_();
                }
            } else if (c.stopping) {
                c.show();
                c.move();
                c.stop_();
            } else if (c.stopped) {
                continue;
            }
            counter++;
            
        }
    }

    void setBestCar() {
        float max = 0;
        int maxIndex = 0;
        for (int i = 0; i< cars.length; i++) {
            if (cars[i].fitness > max) {
                max = cars[i].fitness;
                maxIndex = i;
            }
        }
        bestCar = maxIndex;
  }
    

    void calculateFitness(float goalX, float goalLength) {
        for (Car c : cars) {
            if(c.calculateFitness(goalX, goalLength)) {
                c.inGoal = true;
                inGoal++;
            }
        }
    }

    void calculateFitnessSum() {
        fitnessSum = 0;
        for (Car c : cars) {
            fitnessSum += c.fitness;
        }
    }

    Car selectParent() {
        float rand = random(fitnessSum);
        float runnigSum = 0;

        for (int i = 0; i < cars.length; i++) {
            runnigSum += cars[i].fitness;
            if (runnigSum > rand) {
                return cars[i];
            }
        }
        return null;
    }

    boolean allDead() {
        for (Car c : cars) {
            if (!c.stopped && c.step < 90) {
                return false;
            }
        }
        return true;
    }

    void mutateDemBabies() {
        for (Car c : cars) {
            c.brain.mutate();
        }
    }
    
    
    void TestnaturalSelection() {
        Car parent = TestselectParent();
        Car[] new_gen = new Car[cars.length];
        for (int i=0; i < new_gen.length; i++) {
            new_gen[i] = parent.gimmeBaby(parent);   
        }
        cars = new_gen; //<>//
        int c = 0;
    }
    
    Car TestselectParent() {
        for (int i=0; i < cars.length; i++) {
             if (cars[i].inGoal) {
                 println("Parent was in Goal");
                 return cars[i];
             }
        }
        return cars[0];
    }
    
    void Testcheck() {
        int counter = 0;
         for (Car c : cars) {
              if (c.inGoal) {
                  counter++;
              }
         }
         println("This gen were " + counter + " in the goal");
    }
    
    void naturalSelection() {
        Car[] new_gen = new Car[cars.length];
        int counter = 0;
        calculateFitnessSum();
        setBestCar();
        new_gen[0] = cars[bestCar].gimmeBaby(cars[bestCar]);
        if (cars[bestCar].inGoal) {
            counter++;
        }
        for(int i = 1; i < new_gen.length; i++) {
            Car parent = selectParent(); //<>//
            if (parent.inGoal) {
                 counter++;   
            }
            new_gen[i] = parent.gimmeBaby(parent);
        }
        cars = new_gen;
        gen++;
        println(gen);
        println("This gen there were (" + counter + "/" + cars.length + ") in the goal");
        println("inGoal: " + inGoal);
        inGoal = 0;
    }
    
}
