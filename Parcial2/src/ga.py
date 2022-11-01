import problem
import numpy as np
import matplotlib.pyplot as plt
from geneticalgorithm2 import geneticalgorithm2 as ga
from geneticalgorithm2 import *

x4 = [0.0000, 10.0000]      # Ancho de la viga (b)
x3 = [0.0000, 10.0000]      # Altura de la viga (t)
x2 = [0.0000, 10.0000]      # Longitud de la soldadura (l)
x1 = [x4[0], x4[1]]  # Grosor de la soldadura (h)

varBound = [x1, x2, x3, x4]
params = AlgorithmParams(
    max_num_iteration=9000,
    population_size=100,
    mutation_probability=0.1,
    mutation_discrete_probability=None,
    elit_ratio=0.01,
    parents_portion=0.3,
    crossover_type='uniform',
    mutation_type='uniform_by_center',
    selection_type='roulette',
    max_iteration_without_improv=None
)

model = ga(
    function=problem.Fw,
    dimension=len(varBound),
    variable_type='real',
    variable_boundaries=varBound,
    function_timeout=60,
    algorithm_parameters=params
)

model.run(no_plot=True)
