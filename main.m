%Tomás Chamorro
%201610011014
%03/09/28
clc
clear
close all

global ROUND_ERROR;
ROUND_ERROR = 0.00001;

WORLD = eye(4);
WORLD_SIZE = 15;
xmin = -WORLD_SIZE;
xmax = WORLD_SIZE;
ymin = -WORLD_SIZE;
ymax = WORLD_SIZE;
zmin = -WORLD_SIZE;
zmax = WORLD_SIZE;

%0- Use the Airplane Data Set as object to transform. Ignore the coordinate
%system that that the function build_airplane( ) delivers. Use instead the
%Coordinate System S0 that you will create in (1) to attach it to the airplane.
    [S_ignore,B,Dims]=build_airplane( );


%% 1- Create an arbitrary S0 = [[Ao Oo];[0 1]] Right Handed Canonical (SO(3))
%coordinate system, so that: (a) it is not aligned with the World Coordinate
%System (WCS=eye(4)), (b) it is not located in the origin of WCS. (S0=[X0 Y0 Z0
%O0])

%Random vector u
    u = [0.388;
        0.988;
        0.764];
    u = u/norm(u);

%Random temporal vector that will be used to create a perpendicular vector
%to u
    temp = [0.876 0.675 0.786]';

%Vector v is defined by the cross multiplication of vector u and vector v
    v = cross(u,temp);
    v = v/norm(v);

%Creating of orthogonal vector to both u and v, called w
    w = cross(u,v);
    w = w/norm(w);
    
 S0 = [u v w B(1:3,3);
       0 0 0 1];

 result1 = is_SOn(S0(1:3,1:3));
 if result1 == 1
     disp('S0 is special orthogonal')
else
    disp('S0 is not special orthogonal')
end

 
%% Create an arbitrary M = [[R T];[0 1]] homogeneous transformation, with R
%rotation (i.e. R being SO(3)) with T different from the null translation.
e = [0.876 0.765 0.654]';
e = e/norm(e);
th = pi/8;
[R]=quat_to_rot( e,th );

T = [1 9 8]';
Mf = [R T;
    0 0 0 1];
M0 = S0*WORLD^-1;
B0 = M0*B;
%% 3- Obtain Sf as the transformation M applied on So (Sf=[Xf Yf Zf Of]). Test
%whether Sf is SO(3) (use isSOn() ).

Sf = Mf*S0;
Bf = Mf*B0;
[ result ] = is_SOn( Sf(1:3,1:3) );

if result == 1
     disp('Sf is special orthogonal')
else
    disp('Sf is not special orthogonal')
end

figure(1)
hold on
axis([xmin xmax ymin ymax zmin zmax]);
axis equal;

plt_axes_str(WORLD, WORLD_SIZE, 'k', 'b', 'r',"Xw","Yw","Zw","Ow");
plt_axes_str(S0, 3, 'k', 'b', 'r',"X0","Y0","Z0","O0");
plt_axes_str(Sf, 3, 'k', 'b', 'r',"X0","Y0","Z0","O0");

draw_polyg_faces(B0, Dims, 'c')
draw_polyg_faces(Bf, Dims, 'y')


%% 4- Extract the part of M that contains the quaternion information. Also, express
%which part of M contains the quaternion information (use disp() ).
disp('The information about the Quaternion is contained in the M(1:3,1:3)')
disp(Mf(1:3,1:3))

%% 5- Manually, compute the equivalent quaternion q=[e,th] contained in M. Check
%this q against the obtained by applying rot_to_quat().
[eVects,eVals]= eig(R);
e_prove = real(eVects(1:3,3));
e_prove = e_prove/norm(e_prove);
th_prove = acos(real(eVals(2,2)));

if is_equal(th_prove,th,0.0001) == 0
    th_prove = -th_prove;
    disp('Angles were not matching. They now match')
end

if is_equal(e,e_prove,0.0001) == 0
    e_prove = -e_prove;
end

%% 6- Apply the quaternion q onto S0 to obtain Sq (Sq = [Xq Yq Zq Oq]). Test
%whether Sq is SO(3) (use isSOn() ).
e_prove = e_prove/norm(e_prove);
[R_prove]=quat_to_rot(e_prove,th_prove);

if is_equal(R_prove,R,0.0001) == 1
    disp('The matrix obtained is the same as the one computed arbitrary')
else
    disp('Matrices are different. Please check the calculations performed')
end

MQ = [R_prove T;
    0 0 0 1];

S_Q = MQ*S0;

[ result3 ] = is_SOn( S_Q(1:3,1:3) );

if result3 == 1
     disp('S_Q is special orthogonal')
else
    disp('S_Q is not special orthogonal')
end



%% 7-Create a homogeneous pure rotation using R, called M_R.
zeros1 = zeros(3,1);
M_R = [R zeros1;
    0 0 0 1];

%% 8- Apply a M_ R onto So to obtain S_R. Test whether S_R is SO(3) (use isSOn() ).
S_R = M_R*S0;
B_R = M_R*B0;

plt_axes_str(S_R, 3, 'k', 'b', 'r',"XR","YR","ZR","OR");
draw_polyg_faces(B_R, Dims, 'y')

[ result4 ] = is_SOn( S_R(1:3,1:3) );

if result4 == 1
     disp('SR is special orthogonal')
else
    disp('SR is not special orthogonal')
end


%% 11 - Compute rotation R_q from q. Compare R vs. R_q. Explain the differences or
%similarities (use quat_to_rot() and disp() ).

[R_q]=quat_to_rot( e_prove,th_prove );
disp('As it can be seen in the following displays, both R_q (computed from the quaternium) and the R (Created randomly) are the same rotation matrices')
disp('R_q:')
disp(R_q)
disp('R:')
disp(R)

