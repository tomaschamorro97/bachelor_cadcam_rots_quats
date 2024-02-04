function p_p = perp_pt_line( p, pv, v )
% Oscar Ruiz 02-03-2013
% finds the point p_p nearest to p, lying on parametric 
% line L(lambda) = pv+lambda*v
% INPUTS:
%    p:      (3x1) point (in general) outside line L( )
%    pv:     (3x1) point on line L( )
%    v:      (3x1) direction vector of line L( )
%
% OUTPUTS:
%    p_p:    (3x1) point in line L( ) nearest to p
%  

V = v / norm( v );

temp = p - pv;
temp = temp/ norm(temp);

U = cross( v, temp );

U = U / norm( U );
W = cross( U, V );

A = [V, W, U];

d = inv(A)*(p - pv);

alpha = d(1);
beta = d(2);
gamma = d(3);


p_p = pv + alpha * V;

end

