function [N1 N2 N3] = p3p_distances( d12, d23, d31, c12, c23, c31  )
%P3P_DISTANCES P3P problem - points-to-camera distances.

%
% [N1 N2 N3] = p3p_distances( d12, d23, d31, c12, c23, c31  )
%
%   Input: 
%     d12, d23, d31 .. distances between three points in the space (scalars)
%
%     c12, c23, c31 .. appropriate cosines (scalars)
%
%   Output:
%     N1, N2, N3 .. distances, row vectors 1 x num where 
%                   num is number of solutions. Let integer i >= 1, i <= num,
%                   the N1(i), N2(i), and N3(i) is a single solution.

N1 = [];
N2 = [];
N3 = [];

thr = 1e-4; % threshold for p3p_dverify

[a0 a1 a2 a3 a4] = p3p_polynom( d12, d23, d31, c12, c23, c31 );

% ------------------------------------------------------------------------------
% Case A

% Companion matrix ...
C=[0 0 0 -(a0/a4);
   1 0 0 -(a1/a4);
   0 1 0 -(a2/a4);
   0 0 1 -(a3/a4)];
% Solve for n12 ...
num_sols=eig(C);
j=1;

real_sols=[];

for i=1:size(num_sols)
    out = imag(num_sols(i)) ~= 0;
    if(out==false)
        real_sols(j)=num_sols(i);
        j=j+1;
    end 
end
% Use only real solutions ...
num_sols=real_sols';

for i = 1:size(num_sols)
  n12=num_sols(i);  
  % Replace this with your results
  n13=(d12^2*(d23^2-d31^2*n12^2)+(d23^2-d31^2)*(d23^2*(1+n12^2-2*n12*c12)-d12^2*n12^2))/(2*d12^2*(d23^2*c31-d31^2*c23*n12)+2*(d31^2-d23^2)*d12^2*c23*n12);
  n1 = d12/(sqrt(1+n12^2-2*n12*c12));
  n2 = n1*n12;
  n3 = n1*n13;
  

  

  % Use only solutions with error from p3p_dverify smaller than threshold

  e = p3p_dverify( n1, n2, n3, d12, d23, d31, c12, c23, c31 );

  if( all( abs(e) < thr ) & n1 > 0 & n2 > 0 & n3 > 0 )
    N1 = [ N1 n1 ];
    N2 = [ N2 n2 ];
    N3 = [ N3 n3 ];
  end
end