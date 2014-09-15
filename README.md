CA
==

Cellular automata in Matlab

This directory contains functions supporting cellular automaton simulations in Matlab.  You must implement the 
following functions for a given CA:

  INIT(N) returns an initial NxN grid 

  UPDATE(OLDGRID, T) returns grid at time T+1 based on grid at time T

  SHOWGRID(GRID) displays the grid in an appropriate way, returning a handle to the displayed graphics 
    
  GETCELL returns new value for cell left-clicked on by user
  
  As an exmples, the life/ directory contains these functions written to implement Conway's Game of Life.
  
  See for http://home.wlu.edu/~levys/software/ca/ additional details.
