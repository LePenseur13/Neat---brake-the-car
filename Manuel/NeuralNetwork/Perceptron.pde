class Perceptron {
    float[] weights;
    float[] inputs;
     
     
    Perceptron(int number_inputs, float[] weights_, float[] inputs_) {
        weights = weights_;
        inputs = inputs_;
    }
     
    Perceptron(int number_inputs) {
        weights = new float[number_inputs];
        inputs = new float[number_inputs];
        for (int i = 0; i < weights.length; i++) {
            weights[i] = random(-1,1);
        }
    }

    float activation(float output) {
        if (output > 0) {
            return 1;
        } else {
            return -1;
        }
    }
     
    float guess(float[] inputs) {
        float sum = 0;
        for (int i = 0; i + 1 < inputs.length; i++) {
            sum += inputs[i] * weights[i]; //<>//
        }
        //add bios
        sum += 1 * weights[weights.length - 1];
        return activation(sum);     
    }

    void mutate(float mutationRate) {
        for (int i = 0; i < weights.length; i++) {
            float rand = random(1);
            if (rand < mutationRate) {
                weights[i] = random(-1,1);
            }
        }
    }
}
