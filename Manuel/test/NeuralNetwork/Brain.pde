class Brain {
    int number_neurons = 5;    
    int number_layers = 1; //only counting layers within the hidden layer
    int[] structur = new int[number_layers];
    Perceptron[] neurons;
    Perceptron output_neuron;

    Brain(int number_inputs) {
        neurons = new Perceptron[number_neurons];
        struct();
        for (int i = 0; i < neurons.length; i++) {
            neurons[i] = new Perceptron(number_inputs);
        }
        output_neuron = new Perceptron(number_neurons);
    }
    
    void struct() {
        for (int i = 0; i < structur.length; i++) {
            structur[i] = number_neurons; //not yet finish, it only works with one layer
        }      
    }
    
    boolean activation(float output) {
         if (output >= 0) {
             return true;
         } else {
              return false;   
         }
    }
    
    boolean guess(float[] inputs) {
        float[] outputs;
        for (int i = 0; i < number_layers; i++) {
            outputs = new float[structur[i]];
            for (int j = 0; j < structur[i]; j++) {
                outputs[j] = neurons[j].guess(inputs);
            }
            inputs = outputs;
        }
        float output = output_neuron.guess(inputs);
        return activation(output);   
    }

    void mutate() {
        float mutationRate = 0.00;
        for (Perceptron p : neurons) {
            p.mutate(mutationRate);
        }
    }
}
