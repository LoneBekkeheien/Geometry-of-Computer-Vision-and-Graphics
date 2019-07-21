
function [N1, N2, N3] = p3p_distances( d12, d23, d31, c12, c23, c31  )

N1 = [];
N2 = [];
N3 = [];

thr = 1e-4; 



[a0, a1, a2, a3, a4] = p3p_polynom( d12, d23, d31, c12, c23, c31 );

C = [ 0 0 0, -a0/a4; 1 0 0, -a1/a4; 0 1 0, -a2/a4; 0 0 1, -a3/a4];

eigVals = (eig(C)); 


num_sols = [];

for i =1:size(eigVals)
    if imag(eigVals(i)) == false
        num_sols = [num_sols; eigVals(i)];
    end;    
end;





for i = 1:size(num_sols)
    n12 = num_sols(i);
    firstPart = (d12^2*(d23^2 - d31^2*n12^2) + (d23^2 - d31^2)*(d23^2*(1+ n12^2 - 2*n12*c12) - d12^2*n12^2));
    secondPart = (2*d12^2*(d23^2*c31 - d31^2*c23*n12) + 2*(d31^2 - d23^2)*d12^2*c23*n12);
    n13 = firstPart/secondPart;           
    

    n1 = d12/sqrt(1+n12^2 - 2*n12*c12);
    n2 = n1*n12;
    n3 = n1*n13;


    e = p3p_dverify( n1, n2, n3, d12, d23, d31, c12, c23, c31 );

    if( all( abs(e) < thr ) & n1 > 0 & n2 > 0 & n3 > 0 )
        N1 = [ N1 n1 ];
        N2 = [ N2 n2 ];
        N3 = [ N3 n3 ];
  end
end