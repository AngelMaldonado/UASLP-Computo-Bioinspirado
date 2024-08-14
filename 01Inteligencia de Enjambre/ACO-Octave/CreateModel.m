%
% Copyright (c) 2015, Yarpiz (www.yarpiz.com)
% All rights reserved. Please read the "license.txt" for license terms.
%
% Project Code: YOEA103
% Project Title: Ant Colony Optimization for Traveling Salesman Problem
% Publisher: Yarpiz (www.yarpiz.com)
%
% Developer: S. Mostapha Kalami Heris (Member of Yarpiz Team)
%
% Contact Info: sm.kalami@gmail.com, info@yarpiz.com
%
function model=CreateModel()
    %x=[82 91 12 92 63 9 28 55 96 97 15 98 96 49 80 14 42 92 80 96];
    x=[0.549963E-07 -28.8733 -79.2916 -14.6577 -64.7473 -29.0585 -72.0785 -36.0366 -50.4808 -50.5859 -0.135819 -65.0866 -21.4983 -57.5687 -43.0700];
    %y=[66 3 85 94 68 76 75 39 66 17 71 3 27 4 9 83 70 32 95 3];
    y=[0.985808E-08 -0.797739E-07 -21.4033 -43.3896 21.8982 -43.2167 0.181581 -21.6135 7.37447 -21.5882 -28.7293 -36.0625 7.31942 -43.2506 14.5548];
    n=numel(x);

    D=zeros(n,n); % matriz de costos

    for i=1:n-1
        for j=i+1:n

            D(i,j)=sqrt((x(i)-x(j))^2+(y(i)-y(j))^2);

            D(j,i)=D(i,j);

        end
    end

    model.n=n;
    model.x=x;
    model.y=y;
    model.D=D;
end
