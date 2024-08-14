import knapsack as ks
import numpy as np
import matplotlib.pyplot as plt
# for creating and running optimization model
from geneticalgorithm2 import geneticalgorithm2 as ga
# classes for comfortable parameters setting and getting
from geneticalgorithm2 import *


def fitness(X): return -ks.knapsack(X)


varBound = [(False, True)] * int(ks.objects_count)
params = AlgorithmParams(
    max_num_iteration=200,
    population_size=7,
    mutation_probability=0.1,
    mutation_discrete_probability=None,
    elit_ratio=0.01,
    parents_portion=0.3,
    crossover_type='uniform',
    mutation_type='uniform_by_center',
    mutation_discrete_type='uniform_discrete',
    selection_type='roulette',
    max_iteration_without_improv=None
)

model = ga(
    function=fitness,
    dimension=ks.objects_count,
    variable_type='bool',
    variable_boundaries=varBound,
    function_timeout=60,
    algorithm_parameters=params
)

model.run(no_plot=True)

report = np.abs(np.array(model.report))
plt.plot(report)
plt.xlabel('Iteration')
plt.ylabel('Knapsack Value')
plt.title('Genetic Algorithm for Knapsack')
plt.show()
