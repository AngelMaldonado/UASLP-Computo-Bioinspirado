%% https://www.youtube.com/watch?v=xPkRL_Gt6PI
%% Angel de Jesús Maldonado Juárez

clc; # Limpia la pantalla
clear; # Limpia las variables
close all; # Cierra todas las ventanas gráficas

%% Todos los problemas relacionados con metaheurísticas siguen estos pasos:
%% 1. Definición del problema

CostFunction = @(x) Sphere(x); % @ -> manejador de función (lambda)

nVar = 5; % Número de variables desconocidas (dimensión)

VarSize = [1 nVar]; % Tamaño de la matriz de las variables de decisión

VarMin = -10; % Menor valor de un elemento del vector solución
VarMax = 10; % Mayor valor de un elemento del vector solución

%% 2. Parámetros del PSO

MaxIt = 1000; % Máximo número de iteraciones

nPop = 50; % Número de partículas (población/Swarm Size)

w = 1; % Coeficiente de inercia

wdamp = 0.99; % Límite del coeficiente de inercia

c1 = 2; % Coeficiente de aceleración PERSONAL

c2 = 2; % Coeficiente de aceleración SOCIAL


%% 3. Inicialización

% Plantilla de las partículas
empty_particle.Position = [];
empty_particle.Velocity = [];
empty_particle.Cost = [];
empty_particle.Best.Position = [];
empty_particle.Best.Cost = [];

% Arreglo de población
particle = repmat(empty_particle, nPop, 1); % Repite matrices por ren, col

% Mejor Global
GlobalBest.Cost = inf;

% Inicializar miembros de la población
for i=1:nPop

  % Generar soluciones aleatorias
  particle(i).Position = unifrnd(VarMin, VarMax, VarSize);

  % Inicialización de velocidad
  particle(i).Velocity = zeros(VarSize);

  % Evaluación
  particle(i).Cost = CostFunction(particle(i).Position)

  % Actualizar el mejor personal
  particle(i).Best.Position = particle(i).Position;
  particle(i).Best.Cost = particle(i).Cost;

  % Actualizar el Mejor Global
  if particle(i).Best.Cost < GlobalBest.Cost

    GlobalBest = particle(i).Best;

  endif

end

% Arreglo para almacenar el mejor costo en cada iteración
BestCost = zeros(MaxIt, 1);

%% 4. Ciclo principal del PSO

for it=1:MaxIt

  for i=1:nPop

    % Actualizar velocidad
    particle(i).Velocity = w * particle(i).Velocity ...
                           + c1 * rand(VarSize) .* (particle(i).Best.Position - particle(i).Position) ...
                           + c2 * rand(VarSize) .* (GlobalBest.Position - particle(i).Position);

    % Actualizar posición
    particle(i).Position = particle(i).Position + particle(i).Velocity;

    % Evaluación
    particle(i).Cost = CostFunction(particle(i).Position);

    % Actualizar mejor personal
    if particle(i).Cost < particle(i).Best.Cost

      particle(i).Best.Position = particle(i).Position;
      particle(i).Best.Cost = particle(i).Cost;

      % Actualizar el Mejor Global
      if particle(i).Best.Cost < GlobalBest.Cost

        GlobalBest = particle(i).Best;

  endif

    endif

  endfor

  % Almacenar el mejor costo
  BestCost(it) = GlobalBest.Cost;

  % Mostrar información de la iteración
  disp(['Iteración' num2str(it) ': Mejor Costo Global = ' num2str(BestCost(it))]);

  % Actualización del coeficiente de inercia
  w = w * wdamp;

end

%% 5. Resultados

figure;
plot(BestCost, 'LineWidth', 2);
% semilogy(BestCost, 'LineWidth', 2);
xlabel('Iteraciones');
ylabel('Mejor Costo');
grid on;
