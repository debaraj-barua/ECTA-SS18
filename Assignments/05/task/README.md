For more detailed information I have uploaded a conference paper, "Active Guidance for a Finless ROcket Using Neuroevolution". This should give all of the relevant information needed for implementation (you can of course also ask me questions, but plrease read Section 2 of this paper first, it is just a couple pages). Additions, such as 'burst mutation' and exotic distributions for noise do not need to be followed, only the core of the algorithm as are mentioned:

1. Initialization. The number of hidden units h in the networks that will be formed is specified and a subpopulation of neuron chromosomes is created. Each chromosome encodes the input and output connection weights of a neuron with a random string of real numbers.

1. Evaluation. A set of h neurons is selected randomly, one neuron from each subpopulation, to form the hidden layer of a complete network. The network is submitted to a trial in which it is evaluated on the task and awarded a fitness score. The score is added to the cumulative fitness of each neuron that participated in the network. This process is repeated until each neuron has participated in an average of e.g. 10 trials.

1. Recombination. The average fitness of each neuron is calculated by dividing its cumulative fitness by the number of trials in which it participated. Neurons are then ranked by average fitness within each subpopulation. Each neuron in the top quartile is recombined with a higher-ranking neuron using 1-point crossover and mutation at low levels to create the offspring to replace the lowest-ranking half of the subpopulation.

1. The Evaluation–Recombination cycle is repeated until a network that per- forms sufficiently well in the task is found.

For those interested I have also attached the PhD thesis where this method is described (Chapter 3, pg. 35). The author went on to work with Jurgen Schmidhuber pioneering recurrent deep and convolutional architectures. As a side note, his classmate Ken Stanley (one year behind) created the NEAT algorithm and is a founding member of UberAI labs.
