import java.util.ArrayList;
import java.util.Arrays;

public class NeuralNetwork
{
    // Defines the number of neurons for each layer
    public int[] layers;
    
    /*
     * A matrix of neurons where:
     *    - i is the layer index
     *    - j is the neuron index in the layer
     */
    public float[][] neurons;
    
    /* 
     * A tridimensional array of weights where:
     *   - i is the index of the layer
     *   - j is the index of the neuron where the connection starts in the ith layer
     *   - k is the index of the neuron where the connection ends in the ith + 1 layer
     */
    public float [][][] weights;

    public NeuralNetwork(int []layers)
    {
        this.layers = new int[layers.length];

        for (int i=0; i < layers.length; i++)
        {
            this.layers[i] = layers[i];
        }
        initNeurons();
        initWeights();
    }

    private void initNeurons ()
    {
        neurons = new float[layers.length][layers[0]];
        
        for(int i = 0; i < layers.length; i++)
        {
            neurons[i] = new float[layers[i]];
        }
    }

    private void initWeights()
    {
      weights =  new float[layers.length][layers[0]][layers[0]]; 
      
      for(int i=1; i<layers.length - 1; i++)
      {
        for(int j=0; j < neurons[i].length; j++){
          //int neuronsInPreviousLayer = layers[i - 1];  
          for(int k=0; k < neurons[i+1].length; k++){
            //println(i + "  " + j  + "  " + k);  
            this.weights[i][j][k] = new Float(random(-1,1));
          }
        }
      }
    }
    
    public float[] feedForward(float[] inputs){
      
      for(int i=0; i<inputs.length; i++)
       {
         neurons[0][i] = inputs[i];
       }
       
       for(int i=1; i<inputs.length; i++) //<>//
       {
          for(int j=0; j<neurons[i].length; j++)
         {
           float value = 0f;
           
           for(int k=0; k<neurons[i-1].length; k++){
             value += weights[i-1][j][k] * neurons[i-1][k];
           }
           
           // Function result limits(-1.0, 1.0)
           //neurons[i][j] = (float)atan(value);
           
           // Function result limits(0.0, 1.0)
           neurons[i][j] = (float)(1f/(1 + exp(-value)));
         }
    }
    
    return neurons[neurons.length-1];
  }
  
  public void mutate(){
    int action = round(random(0,2));
    
    for(int i=1; i<weights.length; i++){
      for(int j=0; j < weights[i].length; j++){
        for(int k=0; k < weights[j].length; k++){
          if(action == 1)
            weights[i][j][k] += random(-0.15, 0.15);
          if(action == 2)
            weights[i][j][k] *= random(-0.15, 0.15);
          if(action == 3)
          weights[i][j][k] *= -1;
        }   
      }
    }
  }
  
  public String toString(){
    return "This ANN is composed by:\n" +
            "\t- " + this.layers.length + " layers\n" +
            "\t- " + (this.neurons.length * this.neurons[0].length) + " neurons\n" +
            "\t\t Neurons values: " + Arrays.deepToString(neurons) + "\n" +
            "\t- " + (this.weights.length * this.weights[0].length * this.weights[0][0].length) + " weights\n" + 
            "\t\t Weights values: " + Arrays.deepToString(weights);
  }
}
