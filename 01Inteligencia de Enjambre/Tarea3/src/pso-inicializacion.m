% inicializa la posicion inicial de las particulas
% de forma aleatoria
for i=1:n
  for j=1:m
  x0(i,j)=round(LB(j)+rand()*(UB(j)-LB(j)));
  end
end

x=x0;     % poblacion inicial
v=0.1*x0; % velocidad inicial

% evalua el fitness de las particulas iniciales
for i=1:n
  f0(i,1)=rastrigin(x0(i,:));
end

% busca el mejor global
[fmin0,index0]=min(f0);
pbest=x0;               % mejor personal
gbest=x0(index0,:);     % mejor global inicial