function p_p = perp_pt_segm( p, a, b )
% Oscar Ruiz 02-03-2013
% finds the point p_p nearest to p, lying on segment 
% ab.

V = (b-a);
V = V / norm( V );

temp = p - a;
temp = temp/ norm(temp);

U = cross( v, temp );

U = U / norm( U );
W = cross( U, V );

A = [V, W, U];

d = inv(A)*(p - a);

alpha = d(1);
beta = d(2);
gamma = d(3);


p_p = a + alpha * V;



