% Thicha Melissa Thephasdin na Ayuthya melissa.thephasdin@uni-potsdam.de
% Mariia Merzliakova mariia.merzliakova@uni-potsdam.de


row(1..R):-rows(R).     % Define row indices from 1 to R.
col(1..C):-cols(C).     % Define column indices from 1 to C.
d(0..4).                % Define the range of digit values from 0 to 4.

% Define the positions of lights on the grid.
{ light(R, C) : row(R), col(C) } != 0.

% Define cells that are occupied by digits or empty as empty.
empty(R, C) :- digit(R, C, _), row(R), col(C), d(D).

% Define cells that are not occupied as white.
white(R, C) :- not empty(R, C), row(R), col(C).
0 { light(R, C) } 1 :- white(R, C).

% Constraint to prevent light repetition in the same row and column without a box (empty).
:- light(R, C), light(R1, C), { empty (R2, C): R < R2, R2 < R1}<=0, R < R1.
:- light(R, C), light(R, C1), { empty (R, C2): C < C2, C2 < C1}<=0, C < C1.

% Constraint to ensure lights do not overlap with digits or empty cells.
:- light(R, C), empty(R, C), row(R), col(C).

% Constraint to ensure the number of lights around a digit is equal to the digit value.
:-digit (R,C,D), {light(R+1,C); light(R-1,C); light(R,C+1); light(R,C-1)} != D, d(D).

% Check if a cell is occupied by a light and eliminate conflicting answers.
occupied(R, C1) :- light(R, C), white(R, C1), C1 >= C, { empty(R, C2): C < C2, C2 < C1 } == 0.
occupied(R, C1) :- light(R, C), white(R, C1), C1 <= C, { empty(R, C2): C > C2, C2 > C1 } == 0.
occupied(R1, C) :- light(R, C), white(R1, C), R1 >= R, { empty(R2, C): R < R2, R2 < R1 } == 0.
occupied(R1, C) :- light(R, C), white(R1, C), R1 <= R, { empty(R2, C): R > R2, R2 > R1 } == 0.
:- not occupied(R, C), white(R, C).

#show light/2.