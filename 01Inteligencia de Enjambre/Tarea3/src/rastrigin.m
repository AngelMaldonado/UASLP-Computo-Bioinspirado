function r = rastrigin(x)
  r = 0.0;
  for xi=x
    r += 10 + (xi^2 - 10 * cos(2*pi*xi));
  endfor
