CA
==

Cellular automata in Matlab


<image height=300 align=right src="life.png">

<a href="https://github.com/simondlevy/CA">This repository</a>  contains generic Matlab source code 
supporting cellular automaton simulations in Matlab.To get started, download
and unzip the file, launch Matlab, change to the directory where you put the repository
the file, and type

<pre>
  >> help ca
</pre>

For an example application, the <b>life</b> subdirectory 
contains code for implementing
<a href="http://www.youtube.com/watch?v=0XI6s-TGzSs&hd=1">
Conway's Game of Life</a> on an initially empty grid. You can copy all the code
into a single directory, or use Matlab's path-adding capability to work from
either directory.  You can create and edit forms by left- and right-clicking,
and then watch them move and interact.

<br><br>

I originally developed this software for a computational modeling
<a href="http://home.wlu.edu/~levys/courses/cs102w2011">
course</a>, to help students do the
cellular automata projects (spread of fire and movement of ants) from the
excellent <a href="http://press.princeton.edu/titles/8215.html">
Introduction to Computational Science</a> textbook
by Angela and George Shiflet. The students wrote the initialization and 
update functions, and I provided the generic code and display function.
This approach allows students with little or no programming experience to
use a powerful, industry-standard tool like Matlab to solve an
interesting problem at an appropriate level of abstraction (one line of code
per CA rule).  Because each instruction operates on the entire grid at once,
the approach is supports the recent move toward
<a href="http://portal.acm.org/citation.cfm?id=1504177">parallel thinking</a>
at the introductory level.


<p>
Please <a href="mailto:simon.d.levy@gmail.com">contact</a> me with any questions or 
suggestions.
</body>

