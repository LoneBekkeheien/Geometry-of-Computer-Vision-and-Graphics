close all;

IX = [ 91 17 100 57 28 101 26 42 15 13 ];
C = [1;2;3];
f=1;
R = diag( [1 1 1] );
K = R;
A=1/f*K*R;
P(:,1)=A(:,1);
P(:,2)=A(:,2);
P(:,3)=A(:,3);
P(:,4)=-A*C;

X1 = [0 0 0 1]';
X2 = [1 0 0 1]';
X3 = [0 1 0 1]'; 

X1_proj1=P*X1;
X2_proj1=P*X2;
X3_proj1=P*X3;

X1_proj2=X1_proj1/X1_proj1(3);  %here we divide it by lamda so that it will be representing the point on the image plane, which is in 2D
X2_proj2=X2_proj1/X2_proj1(3);
X3_proj2=X3_proj1/X3_proj1(3);

c12=(X1_proj2.' * (K^(-1)).' * K^(-1) * X2_proj2)/(norm(K^(-1)*X1_proj2)*norm(K^(-1)*X2_proj2));
c23=(X2_proj2.' * (K^(-1)).' * K^(-1) * X3_proj2)/(norm(K^(-1)*X2_proj2)*norm(K^(-1)*X3_proj2));
c31=(X3_proj2.' * (K^(-1)).' * K^(-1) * X1_proj2)/(norm(K^(-1)*X3_proj2)*norm(K^(-1)*X1_proj2));

d12=norm(X2-X1);
d23=norm(X3-X2);
d31=norm(X1-X3);


[N1, N2, N3] = p3p_distances( d12, d23, d31, c12, c23, c31  );


%-------------------------ONE-----------
X1 = [1 0 0]'; X2 = [0 2 0]'; X3 = [0 0 3]'; c12 = 0.9037378393; c23 = 0.8269612542; c31 = 0.9090648231;
[N1, N2, N3] = p3p_distances( d12, d23, d31, c12, c23, c31  );
%-------------------------TWO-----------
X1 = [1 0 0]'; X2 = [0 1 0]'; X3 = [0 0 2]'; c12 = 0.8333333333; c23 = 0.7385489458; c31 = 0.7385489458;
[N1, N2, N3] = p3p_distances( d12, d23, d31, c12, c23, c31  );
%-------------------------THREE-----------
X1 = [1 0 0]'; X2 = [0 2 0]'; X3 = [0 0 3]'; c12 = 0; c23 = 0; c31 = 0;
[N1, N2, N3] = p3p_distances( d12, d23, d31, c12, c23, c31  );


K=[2487.3274086528036	-1.0458236470401807	566.738985409248;
3.631496054503253E-14	2487.1707706865295	414.5207938844943;
0.0	-7.092765731451665E-17	1.0];

 Triplets = nchoosek(IX,3);

load( 'daliborka_01-ux.mat' );
N1=[];
N2=[];
N3=[];

for i=1:120
   X1=x(:,Triplets(i,1));
   X2=x(:,Triplets(i,2));
   X3=x(:,Triplets(i,3));
    A=1/f*K*R;
    P(:,1)=A(:,1);
    P(:,2)=A(:,2);
    P(:,3)=A(:,3);
    P(:,4)=-A*C;

    X1(4)=1;
    X2(4)=1;
    X3(4)=1;
   

    X1_proj1=P*X1;
    X2_proj1=P*X2;
    X3_proj1=P*X3;

    X1_proj2=X1_proj1/X1_proj1(3);  %here we divide it by lamda so that it will be representing the point on the image plane, which is in 2D
    X2_proj2=X2_proj1/X2_proj1(3);
    X3_proj2=X3_proj1/X3_proj1(3);

    c12=(X1_proj2.' * (K^(-1)).' * K^(-1) * X2_proj2)/(norm(K^(-1)*X1_proj2)*norm(K^(-1)*X2_proj2));
    c23=(X2_proj2.' * (K^(-1)).' * K^(-1) * X3_proj2)/(norm(K^(-1)*X2_proj2)*norm(K^(-1)*X3_proj2));
    c31=(X3_proj2.' * (K^(-1)).' * K^(-1) * X1_proj2)/(norm(K^(-1)*X3_proj2)*norm(K^(-1)*X1_proj2));

    d12=norm(X2-X1);
    d23=norm(X3-X2);
    d31=norm(X1-X3);
    
    [n1, n2, n3] = p3p_distances( d12, d23, d31, c12, c23, c31  );
    N1=[N1,n1];
    N2=[N2,n2];
    N3=[N3,n3];

   
end

figure;
hold on;
    plot(1:length(N1),N1/100,'r');
    plot( 1:length(N2),N2/100, 'b');
    plot( 1:length(N3),N3/100,'g');
fig2pdf( gcf, '04_distances.pdf' )
hold off
