function SetF = rotate_set_quaternion( e, theta, Set0)
% Function that rotates a mixed set of vectors or points Set0
% around the axis 'e' crossing the origin by an angle 'theta',
% retuning the rotated set in SetF.
% This function must correctly handle either cartesian or 
% homogeneous points / vectors in the data set 'Set0' 
% (and produce 'SetF' accordingly).
%    e:       (3x1) non unitary vector being the axis of rotation 
%              of the quaternion, anchored in the origin.
%    theta: angle of rotation, positiv in the CCW orientation
%              with respect to 'e'.
%    Set0:     (4x_) or (3x_) matrix with a sequence of points 
%              or vectors mixed in arbitrary order. Set0 is either
%              homogeneous or cartesian.
%    SetF:     (4x_) or (3x_) the rotated version of Set0.
% Note: the function must exactly keep in SetF the sequence of 
% points and vectors of Set0. It also must keep their
% cartesian or homogeneous form.
% Use the following quaternion form:
%     pf=po+(2*F(theta)*(e1 x po))+(2*e1 x (e1 x po))
%.   po:    (3x1) cartesian point or origin-set vector to be rotated
%     e:     unitary axis of rotation
%     theta: rotation angle in radians (CCW w.r.t. 'e') 
%     e1:    sin(theta /2)*e
%     F(theta):cos(theta /2 ).

ERROR_DIST = 0.001;

setF = [];
if (norm(e) < ERROR_DIST)
  disp('error rotate_set_quaternion(): null rotation vector e')
  keyboard
end
    
SetF=Set0;
e = e/norm(e);
F0 =   cos( theta / 2 );
e1 =   sin( theta / 2 ) * e ;
N = size( Set0,2 );

% apply quaternion form for every vector and point in the set
for i=1:N
    p0 = Set0(1:3,i);
    pf = p0 + 2*F0*cross(e1,p0) + 2*cross(e1,cross(e1,p0));
    SetF(1:3,i)= pf;
end


end
    