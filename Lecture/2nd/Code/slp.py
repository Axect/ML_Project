import numpy as np

class pcn:
    """ A basic Perceptron """

    def __init__(self,inputs,targets):
        """ Constructor """
        if np.ndim(inputs) > 1:
            self.nIn = np.shape(inputs)[1]
        else:
            self.nIn = 1
        
        if np.ndim(targets) > 1:
            self.nOut = np.shape(targets)[1]
        else:
            self.nOut = 1
        
        self.nData = np.shape(inputs)[0]

        self.weights = np.random.rand(self.nIn+1, self.nOut)*0.1 - 0.05