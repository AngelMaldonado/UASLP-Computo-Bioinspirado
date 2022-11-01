%% https://www.youtube.com/watch?v=xPkRL_Gt6PI
%% Angel de Jes���s Maldonado Ju���rez

clc; # Limpia la pantalla
clear; # Limpia las variables
close all; # Cierra todas las ventanas gr���ficas

%% Todos los problemas relacionados con metaheur���sticas siguen estos pasos:
%% 1. Definici���n del problema

problem.CostFunction = @(x) Sphere(x); % @ -> manejador de funci���n (lambda)
problem.nVar = 10; % N���mero de variables desconocidas (dimensi���n)
problem.VarMin = -10; % Menor valor de un elemento del vector soluci���n
problem.VarMax = 10; % Mayor valor de un elemento del vector soluci���n

%% 2. Par���metros del PSO

% Constriction Coefficients
kappa = 1;
phi1 = 2.05;
phi2 = 2.05;
phi = phi1 + phi2;
chi = 2 * kappa / abs(2 - phi - sqrt(phi^2 - 4 * phi));

params.MaxIt = 1000; % M���ximo n���mero de iteraciones
params.nPop = 50; % N���mero de part���culas (poblaci���n/Swarm Size)
params.w = chi; % Coeficiente de inercia
params.wdamp = 1; % L���mite del coeficiente de inercia
params.c1 = chi * phi1; % Coeficiente de aceleraci���n PERSONAL
params.c2 = chi * phi2; % Coeficiente de aceleraci���n SOCIAL
params.ShowIterInfo = true; % Show Iteration Info flag

%% 3. Llamado de funci���n PSO

out = PSO_function(problem, params);

BestSol = out.BestSol;
BestCosts = out.BestCosts;

figure;
plot(BestCosts, 'LineWidth', 2);
%semilogy(BestCosts, 'LineWidth', 2);
xlabel('Iteraciones');
ylabel('Mejor Costo');
grid on;
