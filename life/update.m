function newgrid = update(oldgrid, t)
% Returns grid at time T+1 based on grid at time T.
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

newgrid = zeros(size(oldgrid));

% Count neighbors
nbrs = zeros(size(oldgrid));
nbrs = nbrs + north(oldgrid);
nbrs = nbrs + south(oldgrid);
nbrs = nbrs + east(oldgrid);
nbrs = nbrs + west(oldgrid);
nbrs = nbrs + northeast(oldgrid);
nbrs = nbrs + northwest(oldgrid);
nbrs = nbrs + southeast(oldgrid);
nbrs = nbrs + southwest(oldgrid);

% Rules, from http://en.wikipedia.org/wiki/Conway%27s_Game_of_Life#Rules

% 1. Any live cell with fewer than two live neighbours dies.
newgrid(oldgrid == 1 & nbrs < 2) = 0;

% 2. Any live cell with more than three live neighbours dies.
newgrid(oldgrid == 1 & nbrs > 3) = 0;

% 3. Any live cell with two or three live neighbours lives. 
newgrid(oldgrid == 1 & (nbrs == 2 | nbrs == 3)) = 1;

% 4. Any dead cell with exactly three live neighbours becomes live.
newgrid(oldgrid == 0 & nbrs == 3) = 1;
