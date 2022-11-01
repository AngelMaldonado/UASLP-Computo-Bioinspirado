%% ACO Parameters
MaxIt=300;      % Maximum Number of Iterations
nAnt=40;        % Number of Ants (Population Size)
Q=1;
tau0=10*Q/(nVar*mean(model.D(:)));	% Initial Phromone
alpha=1;        % Phromone Exponential Weight
beta=1;         % Heuristic Exponential Weight
rho=0.05;       % Evaporation Rate