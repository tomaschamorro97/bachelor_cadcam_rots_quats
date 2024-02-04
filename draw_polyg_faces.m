function draw_polyg_faces(verts, loops, face_color)
%
% Prof. Oscar Ruiz Salguero 06-03-2018
%
% This function is writen to replace "draw_fill_solid()",
% which, in the past, incorrectly, had different semantics 
% (draw a triang mesh vs. draw a set of flat-faces with no holes )
%
% "draw_polyg_faces()" draws a set of polygonal flat faces which have no holes. 
% The flat faces do not necessarily describe a solid.

% INPUTS:
%	solid:        (3 x _) or (4 x _) array or real numbers. Column 'j' corresponds to
%                 the coordinates of a planar face vertex. 
%	loops:        (1 x _) array of integer numbers. Entry 'j' corresponds to
%                 the number of vertices of face 'j'. Face vertices are sequentially
%                 stored in the array 'solid'.
%	face_color:   One of 'm', 'c', 'b', 'y', 'g', 'r', 'k'  corresponding to
%                 the color to draw the faces of the solid. If face_color is 'X'
%                 the drawing is in wireframe format with color 'k'.
                
[ Num_coords, N_verts ] = size(verts);

low_pointer = 1;
N_faces = size(loops, 2);

for face=1:N_faces
    loop=face;
    up_pointer = low_pointer + loops(loop)-1;
    loop_i = verts(:,low_pointer:up_pointer);
    loop_i = [loop_i loop_i(:,1)];
    if (face_color == 'X') | (face_color == 'x')
        plot3(loop_i(1,:),loop_i(2,:),loop_i(3,:),'k')
    else
        fill3(loop_i(1,:),loop_i(2,:),loop_i(3,:),face_color)
    end
    hold on
    low_pointer = up_pointer+1;
end    





