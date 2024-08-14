#include <iostream>
#include <stdlib.h>
#include <time.h>
#include <math.h>

#define antNum 7

using namespace std;

int main()
{
    int n = 7;
    float weight[n] = {2.5, 1, 6, 2.5, 1.5, 3, 5};
    float value[n] = {750000, 500000, 2750000, 950000, 1850000, 3250000, 3950000};
    int objectsExplored[n];

    int sackSize = 10;

    float tau[n], eta[n], Dtau[n]; // remaining pheromone and inspiring factor
    float alpha = 1, beta = 2;
    for (int i = 0; i < n; i++)
    {
        tau[i] = 1;
        eta[i] = (float)value[i] / (float)weight[i];
        objectsExplored[i] = 0;
    }

    int nc = 1000; // loop times
    float tabu[antNum][n], Move[antNum][n];
    float probability[antNum][n];
    float curr_weight[antNum], curr_value[antNum];
    int bestSolution = 0;

    for (int i = 0; i < antNum; i++)
    {
        for (int j = 0; j < n; j++)
        {
            tabu[i][j] = 0;
            probability[i][j] = 0;
        }
    }

    for (int i = 0; i < antNum; i++)
    {
        Move[i][i] = 1; // every ant on the first items initially
        tabu[i][i] = 1;
        curr_value[i] = value[i];
        curr_weight[i] = sackSize - weight[i];
    }
    while (nc > 0)
    {
        for (int i = 0; i < antNum; i++) // calculate moving probability
        {
            float sum = 0;
            for (int j = 0; j < n; j++)
                if (tabu[i][j] != 1)
                    sum += pow(tau[j], alpha) * pow(eta[j], beta);
            for (int j = 0; j < n; j++)
            {
                if (tabu[i][j] == 1)
                    probability[i][j] = 0;
                else
                    probability[i][j] = pow(tau[j], alpha) * pow(eta[j], beta) / sum;
            }
        }

        for (int i = 0; i < antNum; i++) // moving to new points
        {
            for (int j = 0; j < n; j++)
            {
                float rann;
                srand(time(NULL));
                rann = (rand() % 100) * 0.01 / antNum;
                if (probability[i][j] > rann && curr_weight[i] >= weight[j])
                {
                    Move[i][j] = 1;
                    tabu[i][j] = 1;
                    curr_weight[i] -= weight[j];
                    curr_value[i] += value[j];
                    if (objectsExplored[j] != 1)
                    {
                        objectsExplored[j] = 1;
                        if (objectsExplored[i] != 1)
                            objectsExplored[i] = 1;
                    }
                    break;
                }
            }
        }

        for (int i = 0; i < antNum; i++) // updating best solution
            if (curr_value[i] > bestSolution)
                bestSolution = curr_value[i];

        float Q = 1; // calculating delta tau
        for (int i = 0; i < antNum; i++)
        {
            for (int j = 0; j < n; j++)
            {
                if (Move[i][j] == 1)
                {
                    Dtau[j] = Q / curr_weight[i];
                    Move[i][j] = 0;
                    break;
                }
            }
        }

        float rho = 0.5; // updating tau
        for (int i = 0; i < n; i++)
            tau[i] = rho * tau[i] + Dtau[i];
        for (int i = 0; i < n; i++)
            Dtau[i] = 0;

        nc--;
    }

    for (int i = 0; i < n; i++)
        cout << objectsExplored[i] << "\t\t";
    cout << endl;

    cout << bestSolution << endl;
    return 0;
}