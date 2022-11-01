%% https://www.youtube.com/watch?v=xPkRL_Gt6PI
%% Angel de Jesús Maldonado Juárez

clc; # Limpia la pantalla
clear; # Limpia las variables
close all; # Cierra todas las ventanas gráficas

%% Todos los problemas relacionados con metaheurísticas siguen estos pasos:
%% 1. Definición del problema

problem.CostFunction = @(x) Sphere(x); % @ -> manejador de función (lambda)
problem.nVar = 5; % Número de variables desconocidas (dimensión)
problem.VarMin = -10; % Menor valor de un elemento del vector solución
problem.VarMax = 10; % Mayor valor de un elemento del vector solución

%% 2. Parámetros del PSO

params.MaxIt = 1000; % Máximo número de iteraciones
params.nPop = 50; % Número de partículas (población/Swarm Size)
params.w = 1; % Coeficiente de inercia
params.wdamp = 0.99; % Límite del coeficiente de inercia
params.c1 = 2; % Coeficiente de aceleración PERSONAL
params.c2 = 2; % Coeficiente de aceleración SOCIAL
params.ShowIterInfo = true; % Show Iteration Info flag

%% 3. Llamado de función PSO

out = PSO_function(problem, params);

BestSol = out.BestSol;
BestCosts = out.BestCosts;

figure;
plot(BestCosts, 'LineWidth', 2);
%semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteraciones');
ylabel('Mejor Costo');
grid on;
