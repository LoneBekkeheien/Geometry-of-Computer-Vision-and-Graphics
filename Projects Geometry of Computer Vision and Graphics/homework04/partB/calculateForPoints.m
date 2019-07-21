function [N1, N2, N3] = calculateForPoints(P, K, X1, X2, X3, c12, c23, c31)

if c12 == -1 && c23 == -1 && c31 == -1
    % 3x1
    X1in2D = P*X1;
    X2in2D = P*X2;
    X3in2D = P*X3;

    X1in2D = X1in2D/X1in2D(3);
    X2in2D = X2in2D/X2in2D(3);
    X3in2D = X3in2D/X3in2D(3);
    
    c12 = (X1in2D.' * (K^(-1)).' * K^(-1) * X2in2D)/( norm(K^(-1)*X1in2D) * norm(K^(-1)*X2in2D) );
    c23 = (X2in2D.' * (K^(-1)).' * K^(-1) * X3in2D)/( norm(K^(-1)*X2in2D) * norm(K^(-1)*X3in2D) );
    c31 = (X3in2D.' * (K^(-1)).' * K^(-1) * X1in2D)/( norm(K^(-1)*X3in2D) * norm(K^(-1)*X1in2D) );
end

d12 = norm(X2 - X1);
d23 = norm(X3 - X2);
d31 = norm(X1 - X3);


[N1, N2, N3] = p3p_distances( d12, d23, d31, c12, c23, c31  );