from geneticalgorithm import geneticalgorithm as ga
import matplotlib.pyplot as plt
import rastrigin as rstr
import numpy as np

params = {
    'max_num_iteration': 1200,              # def None
    'population_size': 350,                 # def 100
    'mutation_probability': 1,              # def 0.1
    'elit_ratio': 0.056,                    # def 0.01
    'crossover_probability': 1,             # def 0.5
    'parents_portion': 0.5,                 # def 0.3
    'crossover_type': 'two_point',          # def uniform
    'max_iteration_without_improv': 350     # def None
}

nvar = 10
varbound = np.array([[-0.99, 0.89]]*nvar)
def func(X): return np.log(rstr.rastriginfcn(X))


model = ga(function=func,
           dimension=nvar,
           variable_type='real',
           variable_boundaries=varbound,
           algorithm_parameters=params)

model.run()
