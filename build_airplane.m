function [S,B,Dims]=build_airplane( )
% This function Generates a simplified airplane
% and an attached coordinate system.
% OUTPUT
%   B: (4 x _) array or real numbers. Column 'j' corresponds to
% the coordinates of a planar face vertex.
%   Dims: (1 x _) array of integer numbers. Entry 'j' corresponds to
% the number of vertices of face 'j'. Face vertices are sequentially
% stored in the array 'B'.
%   S: Right Handed Canonical Coordinate System attached to the
% Body B, as follows: S=[Xi Yi Zi Oi] with Xi along the
% fuselage axis and Zi being vertical positive.
% The Oi coincides with the tail of the airplane and
% the (0,0,0) point.
% Write the function to generate the airplane B as per Figure 1 with the following measures: transversal
% span=2, height=0.5, axial span=3.0. Likewise, attach to the airplane a RHCC System Sinternal with Xinternal
% along the fuselage axis and Zinternal being vertical positive.

B = [0 0 0 1
    0 1 0 1
    3 0 0 1
    0 -1 0 1
    0 0 0 1
    3 0 0 1
    0 0 0.5 1
    0 0 0 1]';
Dims = [4 3];
S = eye(4);

end
