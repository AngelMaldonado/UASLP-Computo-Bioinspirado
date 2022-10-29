## Copyright (C) 2022 amald
##
## This program is free software: you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation, either version 3 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful,
## but WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
## GNU General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program.  If not, see <https://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {@var{retval} =} rosenbrock (@var{input1}, @var{input2})
##
## @seealso{}
## @end deftypefn

## Author: amald <amald@ROGSTRIXANGEL>
## Created: 2022-10-23

FitnessFunction = @(x)log(rastrigin(x));
numberOfVariables = 10;
IP = repelem(-1, 10);
lb = repelem(-1, 10);
ub = repelem(1, 10);
opts = gaoptimset('Generations', 100,
                  'PopulationSize', 200,
                  'InitialPopulation', IP,
                  'UseParallel', 'never',
                  'Vectorized', 'off');

[x, fval, exitflag, output, population, scores] = ga(FitnessFunction, numberOfVariables,[],[],[],[], lb, ub, [], opts);

