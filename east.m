function egrid = east(grid)
% EAST(GRID) returns values in points east of points in GRID, with periodic
% boundary conditions

egrid = circshift(grid, [0 -1]);
