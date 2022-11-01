import pandas as pd
import numpy as np

#######################################################
#                    ACO PARAMETERS                   #
#######################################################
ants = 100  # Number of ants
alpha = 1  # Pheromone exponential weight
beta = 1  # Heuristic exponential weight
backpack_weight = 10  # backpack max weight
max_iter = 100  # Repetitions of the algorithm

#######################################################
#                    INITIALIZATION                   #
#######################################################
items = pd.read_csv('items.csv')  # Read items from file

tau = np.ones(items.shape[0])  # Pheromones array
eta = []  # Heuristic array
for index, row in items.iterrows():
    eta.append(float(row['value'])/float(row['weight']))

antsTour = np.ones([ants, items.shape[0]], dtype=float)
antsCosts = np.ones([ants, items.shape[0]], dtype=float)
probability = np.zeros([ants, items.shape[0]], dtype=float)
curr_weight = backpack_weight - items['weight']
curr_value = items['value']

best_sol = 0
best_profit = 0  # Initial best profit

for iteration in range(max_iter):
    for ant in range(ants):  # Main ACO loop
        for item in range(items.shape[0]):  # Move ants based on n-items
            probability[ant][item] = (tau**alpha*eta**beta)/sum(probability)
