import numpy as np

def rastriginfcn(X):
    A = 10.0
    delta = [x**2 - A * np.cos(2 * np.pi * x) for x in X]
    y = A + sum(delta)
    return y