function [R, C] = p3p_RC( N, u, X, K )
%P3P_RC  P3P problem - absolute camera pose and orientation
%   [R C] = p3p_RC( N, u, X )
%     
%   Input:
%     N .. 1x3, distances (eta) along rays, single solution, obtained from
%           p3p_distances. If [N1 N2 N3] = p3p_distances( ... ), then for 
%           particular i the distances are 
%                 N = [ N1(i) N2(i) N3(i) ]
%     u .. 2x3, corresponding three image points (column vectors)
%
%     X .. 3x3, corresponding three 3D points (column vectors)
%
%     K .. 3x3 calibration matrix
%       
%   Output:
%     R .. matrix of rotation (3x3)
%     C .. camera centre
n1 = N(1,1);
n2 = N(1,2);
n3 = N(1,3);

u = [u; 1 1 1];

Kinv = K^(-1);
u = Kinv*u;

Y1e = n1*u(:,1)/norm(u(:,1));
Y2e = n2*u(:,2)/norm(u(:,2));
Y3e = n3*u(:,3)/norm(u(:,3));

Z2e = Y2e - Y1e;
Z3e = Y3e - Y1e;
Z1e = cross(Z2e,Z3e);

Z2d = X(:, 2)-X(:,1);
Z3d = X(:, 3)-X(:,1);
Z1d = cross(Z2d,Z3d);

mat1 = [Z1e, Z2e, Z3e];

mat2=[Z1d Z2d Z3d]^(-1);
R=mat1*mat2;

C = X(:,1)- transpose(R)*Y1e;


f =0;