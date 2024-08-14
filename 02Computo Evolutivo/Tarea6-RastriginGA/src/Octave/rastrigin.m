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

function y = rastrigin (X)
  d = length(X);
  sum = 0;
  for ii = 1:d
    xi = X(ii);
    sum = sum + (xi^2 - 10*cos(2*pi*xi));
  end

  y = 10*d + sum;
endfunction
