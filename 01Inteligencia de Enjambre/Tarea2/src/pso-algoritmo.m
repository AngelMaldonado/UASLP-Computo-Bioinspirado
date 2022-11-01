ite=1;        % iteracion actual
tolerance=1;  % tolerancia de error

% hasta que no se llegue al maximo de iteraciones
% o mientras no se haya llegado a la tolerancia de error
while ite<=maxite && tolerance>10^-12
  % actualiza el peso inercial
  w=wmax-(wmax-wmin)*ite/maxite;

  % actualiza la velocidad de las particulas
  for i=1:n
    for j=1:m
      v(i,j)=w*v(i,j)+c1*rand()*(pbest(i,j)-x(i,j))...
      +c2*rand()*(gbest(1,j)-x(i,j));
    end
  end

  % actualiza la posicion de las particulas
  for i=1:n
    for j=1:m
      x(i,j)=x(i,j)+v(i,j);
    end
  end

  % manejo de las particulas que exceden los limites
  for i=1:n
    for j=1:m
      if x(i,j)<LB(j)
        x(i,j)=LB(j);
      elseif x(i,j)>UB(j)
        x(i,j)=UB(j);
      end
    end
  end

  % evaluacion del fitness de las particulas
  for i=1:n
    f(i,1)=rosenbrock(x(i,:));
  end

  % actualizando el mejor local de cada particula
  for i=1:n
    if f(i,1)<f0(i,1)
        pbest(i,:)=x(i,:);
    f0(i,1)=f(i,1);
    end
  end

  % encuentra la mejor particula global
  [fmin,index]=min(f0);
  ffmin(ite,run)=fmin;    % busca el mejor fitness
  ffite(run)=ite;         % guardando el numero de iteracion
  
  % actualiza la particula gbest (mejor global)
  % y fmin0 (mejor fitness global)
  if fmin<fmin0
    gbest=pbest(index,:);
    fmin0=fmin;
  end

  % calcula la tolerancia de error
  if ite>100;
    tolerance=abs(ffmin(ite-100,run)-fmin0);
  end

  % muestra los resultados de la iteracion
  if ite==1
    disp(sprintf('Iteration Best particle Objective fun'));
  end
    disp(sprintf('%8g %8g %8.4f',ite,index,fmin0));
  ite=ite+1;
end