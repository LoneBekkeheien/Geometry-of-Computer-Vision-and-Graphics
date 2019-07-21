C =  [1; 2; -3];
f=1;
K = diag( [1 1 1]);
R = diag( [1 1 1]);


A = 1/f*K*R;
P = [A -A*C];

X1 = [0 0 0 1]'; 
X2 = [1 0 0 1]'; 
X3 = [0 1 0 1]';

Y1e= R*(X1(1:3)-C);


[N1, N2, N3] = calculateForPoints(P, K,  X1, X2, X3, -1, -1, -1);


X1proj2D = P*X1;
X2proj2D = P*X2;
X3proj2D = P*X3;

u = [X1proj2D/X1proj2D(3,1), X2proj2D/X2proj2D(3,1), X3proj2D/X3proj2D(3,1)];
u = u(1:2, :);


X = [X1(1:3) X2(1:3) X3(1:3)];

for i=1:2
    g = N1(1,i);
    
    N = [N1(1,i) N2(1,i) N3(1,i) ];
    
    [R, C] = p3p_RC( N, u, X, K )
    
end;

ix =[ 91 17 100 57 28 101 26 42 15 13 ];
comb = nchoosek(ix, 3);
load( 'daliborka_01-ux.mat' ); 


maxErrors = [];
stuff = {};

sizeComb = size(comb,1);
for k=1:sizeComb
     combInd = comb(k,:);
     U = [u(:,combInd(1)) u(:,combInd(2)) u(:,combInd(3))];
     u1 = [U(:,1);1];
     u2 = [U(:,2);1];
     u3 = [U(:,3);1];
     K = [2487.3274086528036	-1.0458236470401807	566.738985409248;
            3.631496054503253E-14	2487.1707706865295	414.5207938844943;
            0.0	-7.092765731451665E-17	1.0];
     
     X1 = x(:, combInd(1));
     X2 = x(:, combInd(2));
     X3 = x(:, combInd(3));
     X = [X1 X2 X3];
     
     g=u1.' * (K^(-1));
     c12 = (u1.' * (K^(-1)).' * K^(-1) * u2)/( norm(K^(-1)*u1) * norm(K^(-1)*u2) );
     c23 = (u2.' * (K^(-1)).' * K^(-1) * u3)/( norm(K^(-1)*u2) * norm(K^(-1)*u3) );
     c31 = (u3.' * (K^(-1)).' * K^(-1) * u1)/( norm(K^(-1)*u3) * norm(K^(-1)*u1) );
     
     d12 = norm(X2 - X1);
     d23 = norm(X3 - X2);
     d31 = norm(X1 - X3);
     

    [N1, N2, N3] = p3p_distances( d12, d23, d31, c12, c23, c31  );  
    
    
    sizeN = size(N1,2);
    for i=1:sizeN
        N = [N1(i), N2(i),N3(i)];
        [R, C] = p3p_RC( N, U, X, K );
        
              
        P = K*R;
        P(:,4) = -K*R*C;
        
        errorMax =0;
        sizeX= size(x,2);
        for j=1:sizeX
            uj = P*[x(:,j);1];
            uj = uj/uj(3);                        
            ej = norm(uj - [u(:,j); 1]);
            errorMax = max(ej, errorMax); 
        end;
        
        maxErrors = [maxErrors errorMax];
        stuffSize = size(stuff,2) + 1;
        stuff{stuffSize} = {R, C, P, errorMax, combInd};
        
    end;     
end;


[~, minInd] = min(maxErrors);
stuffMinError = stuff{minInd};
R = stuffMinError{1};
C = stuffMinError{2};
P = stuffMinError{3};
errorMax = stuffMinError{4};
point_sel = stuffMinError{5};
save('04_p3p.mat', 'R', 'C', 'point_sel', '-v6');


pointsP = [];
for i=1:size(x,2)
    xxx = x(:,i);
    projX = P*[x(:,i); 1];
    projX = projX/projX(3);
    pointsP = [pointsP projX(1:2)];
end;
img = imread( 'daliborka_01.jpg' );
subfig(2,2,1);
image(img);

hold on
title('Reprojected errors(100x enlarged)');
xlabel('x [px]');
ylabel('y [px]');

plot(u(1,:), u(2,:), 'b.', 'linewidth', 1);
plot(u(1, point_sel), u(2, point_sel), 'y.', 'linewidth', 1); 

e = 100*(pointsP-u);
for i = 1 : size(x,2)
    plot( [ u(1,i) u(1,i)+e(1,i) ], [ u(2,i) u(2,i)+e(2,i) ], 'r-', 'linewidth', 1 );
end
hold off
axis image;
fig2pdf( gcf, '04_RC_projections_errors.pdf' );


subfig(2,2,1);
hold on
title('Maximal reproj. err. for tested P');
xlabel('trial');
ylabel('log10 of max. err. [px]');
plot(1:size(pointsP,2), log10(pointsP),'b.','linewidth', 1);
hold off
fig2pdf( gcf, '04_RC_maxerr.pdf')





subfig(2,2,1);
errorReprojectionMatrix = zeros([1 size(x,2)]);
for i = 1 : size(x,2)
    errorReprojectionMatrix(i) = norm(u(:,i)-pointsP(:,i));
end
hold on
title('All point reproj. errors for the best P');
xlabel('point index');
ylabel('reproj. err. [px]');
plot( 1: size(x,2), errorReprojectionMatrix, 'linewidth', 1 )
hold off
fig2pdf( gcf, '04_RC_pointerr.pdf' );



Delta = [1 0 0;
    0 1 0; 
    0 0 0];

Epsilon = Delta * R^(-1);
d = [0;0;0];
e = C;

subfig( 2, 3, 3 );
plot_csystem(Delta, d, 'black', '\delta');
plot_csystem(Epsilon, e, 'magenta', '\epsilon');
xlabel('X');
ylabel('Y');
zlabel('Z');
hold on
sizeX = size(x, 2) ;
for i=1 : sizeX   
    plot3( x(1,i), x(2,i), x(3,i), 'b.' );    
end;

for st = stuff
    CCC = st{1}{2};
    plot3(CCC(1,:),CCC(2,:),CCC(3,:),'r.');
end;

hold off
axis equal;
fig2pdf( gcf, '04_scene.pdf' )


