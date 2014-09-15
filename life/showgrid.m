function h = showgrid(grid)
% Displays the grid in a useful way.
% Called automatically by CA program; do not call from command-line.
% You modify this for each CA application.
%
% Copyright (C) 2009  Simon D. Levy
%
% This program is free software; you can redistribute it and/or modify
% it under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 2 of the License, or
% (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.


% add bogus row, column with min max values to force full display
n = length(grid);
dispgrid = [grid; zeros(1, n)];
dispgrid = [dispgrid, zeros(n+1, 1)];
dispgrid(n+1,1) = 0;
dispgrid(n+1,2) = 1;

% use black-on-white color map
cmap = colormap;
cmap(1,:) = 1;
cmap(2:end,:) = 0;
colormap(cmap);

% display inverse of grid in b/w, square, no grid lines, no axis ticks
h = pcolor(dispgrid);
axis square
shading flat
set(gca, 'XTick', [])
set(gca, 'YTick', [])
