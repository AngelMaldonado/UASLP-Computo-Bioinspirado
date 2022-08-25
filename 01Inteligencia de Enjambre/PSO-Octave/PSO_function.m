function out = PSO_function(problem, params)
  %% 1. Definición del problema

  CostFunction = problem.CostFunction; % @ -> manejador de función (lambda)

  nVar = problem.nVar; % Número de variables desconocidas (dimensión)

  VarSize = [1 nVar]; % Tamaño de la matriz de las variables de decisión

  VarMin = problem.VarMin; % Menor valor de un elemento del vector solución
  VarMax = problem.VarMax; % Mayor valor de un elemento del vector solución

  %% 2. Parámetros del PSO

  MaxIt = params.MaxIt; % Máximo número de iteraciones

  nPop = params.nPop; % Número de partículas (población/Swarm Size)

  w = params.w; % Coeficiente de inercia
  wdamp = params.wdamp; % Límite del coeficiente de inercia
  c1 = params.c1; % Coeficiente de aceleración PERSONAL
  c2 = params.c2; % Coeficiente de aceleración SOCIAL

  ShowIterInfo = params.ShowIterInfo; % Bandera para mostrar información de las iteraciones

  MaxVelocity = 0.2 * (VarMax - VarMin);
  MinVelocity = -MaxVelocity;

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
  BestCosts = zeros(MaxIt, 1);

  %% 4. Ciclo principal del PSO

  for it=1:MaxIt

    for i=1:nPop

      % Actualizar velocidad
      particle(i).Velocity = w * particle(i).Velocity ...
                             + c1 * rand(VarSize) .* (particle(i).Best.Position - particle(i).Position) ...
                             + c2 * rand(VarSize) .* (GlobalBest.Position - particle(i).Position);

      % Aplicar límites de velocidad
      particle(i).Velocity = max(particle(i).Velocity, MinVelocity);
      particle(i).Velocity = min(particle(i).Velocity, MaxVelocity);

      % Actualizar posición
      particle(i).Position = particle(i).Position + particle(i).Velocity;

      % Aplicar límite superior e inferior
      particle(i).Position = max(particle(i).Position, VarMin);
      particle(i).Position = min(particle(i).Position, VarMax);

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
    BestCosts(it) = GlobalBest.Cost;

    % Mostrar información de la iteración
    if ShowIterInfo
      disp(['Iteracion ' num2str(it) ': Mejor Costo Global = ' num2str(BestCosts(it))]);
    endif

    % Actualización del coeficiente de inercia
    w = w * wdamp;

  end

  %% 5. Resultados

  out.pop = particle;
  out.BestSol = GlobalBest;
  out.BestCosts = BestCosts;

end
