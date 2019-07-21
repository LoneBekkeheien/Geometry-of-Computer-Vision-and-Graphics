close all;
load('09a_data.mat');

load( '30edges.mat' );
point_sel=[13    4    8     19    30    26     6    23    16    24     7    28];

% 
% e = edges(:,1:(size(edges, 2)));
% [points,edges] = edit_points( { imgs{1}, imgs{2} }, { u1, u2}, e);
% 
% save('edgesTrying.mat', 'edges');

K= [2487.3274086528036	-1.0458236470401807	566.738985409248
3.631496054503253E-14	2487.1707706865295	414.5207938844943
0.0	-7.092765731451665E-17	1.0
];

X=zeros([3 30]);

P1= [2487.3274086528036	-1.0458236470401807	566.738985409248 0;
3.631496054503253E-14	2487.1707706865295	414.5207938844943 0;
0.0	-7.092765731451665E-17	1.0 0
];


imgs={};
imgs{1} = imread( 'daliborka_01.jpg' ); 
imgs{2} = imread( 'daliborka_23.jpg' );
G=sqrt(2)*E/(sqrt(sum(diag(E'*E))));

C=null(G);

v1=C(1);
v2=C(2);
v3=C(3);


skews= [0   -v3  v2;
    v3   0  -v1;
   -v2   v1  0]; %because skew symmetric
point_sel=[13    4    8     19    30    26     6    23    16    24     7    28];

u1=u1(:, 1:30);
u2=u2(:, 1:30);

sgij=[G(:,1) G(:,2) G(:,3) cross(G(:,1), G(:,2)) cross(G(:,2), G(:,3)) cross(G(:,1), G(:,3))];

vij=[skews(:,1) skews(:,2) skews(:,3) cross(skews(:,1), skews(:,2)) cross(skews(:,2), skews(:,3)) cross(skews(:,1 ), skews(:,3))];
R=sgij/vij;
P2=[K*R -K*R*C];


for i=1:30
    mat=[[u1(:, i); 1] [0;0;0] -P1(:,1:3);
        [0;0;0] [u2(:,i);1] -P2(:,1:3)]\[0;0;0; P2(:,4)];
    X(:,i)=mat(3:5);
end



save('09b_data.mat', 'Fe', 'E', 'R', 'C', 'P1', 'P2', 'X', 'u1', 'u2', 'point_sel');




%PLOTS
load( '30edges.mat' );

x1 = [];
x2 = [];

for i = 1:30
    xmid = P1*[X(:,i); 1];
    xmid = xmid(1:2)/xmid(3);
    x1 = [x1 xmid];
end;


for i = 1:30
    xmid = P2*[X(:,i); 1];
    xmid = xmid(1:2)/xmid(3);
    x2 = [x2 xmid];
end;


akser = {};
akser{1} = axes( 'pos', [0.10 0.35 0.37 0.39] );
imagesc( imgs{1} )


axis equal 
hold on
title('Corresponding points and edges');


for i = 1:30   
    edg1 = x1(:, edges(1,i));
    edg2 = x1(:, edges(2,i));
    plot( [edg1( 1, 1 ) edg2( 1, 1 )], [edg1( 2, 1 ) edg2( 2, 1 )], 'y-');
end;

for i = 1:30
	plot( u1( 1, i ), u1( 2, i ), 'b.');
    plot( x1( 1, i ), x1( 2, i ), 'ro');
end;





akser{2} = axes( 'pos', [0.6 0.35 0.35 0.45] );
imagesc( imgs{2} )
hold on
title('Corresponding points and edges');


for i = 1:30    
    edg1 = x2(:, edges(1,i));
    edg2 = x2(:, edges(2,i));
    plot( [edg1( 1, 1 ) edg2( 1, 1 )], [edg1( 2, 1 ) edg2( 2, 1 )], 'y-');
end

for i = 1:size( u2, 2 )
	plot( u2( 1, i ), u2( 2, i ), 'b.');
    plot( x2( 1, i ), x2( 2, i ), 'ro');
end

fig2pdf( gcf, '09_reprojection.pdf' );






%--------------new figur-----------------

title('from top wire-frame model reconstruction');
subfig(2,3,1);
hold on

ge = 0.7854;
   mat1 = diag([1 1 1]);
    mat2=mat1;

    mat3 = [
        1 0    0;
        0 cos(ge) -sin(ge);
        0 sin(ge) cos(ge);
    ];
    mat = mat3*mat1*mat2;

for i = 1:30
    edge1 = mat*X(:, edges(1,i));
    edge2 = mat*X(:, edges(2,i));
    plot3( [edge1( 1, 1 ) edge2( 1, 1 )], [edge1( 2, 1 ) edge2( 2, 1 )], [edge1( 3, 1 ) edge2( 3, 1 )], 'k-', 'linewidth', 1);
end

fig2pdf( gcf, '09_view1.pdf' );

%------------------------------new figure-------------------------

subfig(2,4,1);
hold on
title('from side wire-frame model reconstruction');

ge = -0.51;
    mat3 = [
        1 0    0;
        0 cos(ge) -sin(ge);
        0 sin(ge) cos(ge);
    ];

 mat = mat3*mat1*mat2;

for i = 1:30
    edge1 = mat*X(:, edges(1,i));
    edge2 = mat*X(:, edges(2,i));
    plot3( [edge1( 1, 1 ) edge2( 1, 1 )], [edge1( 2, 1 ) edge2( 2, 1 )], [edge1( 3, 1 ) edge2( 3, 1 )], 'k-');
end;

axis equal;
fig2pdf( gcf, '09_view2.pdf' );

%---------------------------new figure----------------------
subfig(2,5,1);
hold on
title('wire-frame model reconstruction in General');

ge = 0;
    mat3 = [
        1 0    0;
        0 cos(ge) -sin(ge);
        0 sin(ge) cos(ge);
    ];

 mat = mat3*mat1*mat2;

for i = 1:30

    edge1 = mat*X(:, edges(1,i));
    edge2 = mat*X(:, edges(2,i));
    plot3( [edge1( 1, 1 ) edge2( 1, 1 )], [edge1( 2, 1 ) edge2( 2, 1 )], [edge1( 3, 1 ) edge2( 3, 1 )], 'k-', 'linewidth', 1);
end;

fig2pdf( gcf, '09_view3.pdf' );



load('08_data.mat');
point_sel=[13    4    8     19    30    26     6    23    16    24     7    28];
%-----------------------EX AND FX---------------------------

Ex = K' * F * K;
[U D V] = svd( Ex ); 
D(2,2) = D(1,1);
Ex = U * D * V';
Fx=inv(K)'*Ex*inv(K);

  for i=1:52
         
            l1i=Fx'*[u2(:,i);1];
            lamda1=1/sqrt(l1i(1)^2+l1i(2)^2);
            l2i=Fx*[u1(:,i);1];
            lamda2=1/sqrt(l2i(1)^2+l2i(2)^2);
            d1i=lamda1*abs([u1(:,i);1]'*l1i); %should be dot product
            d2i=lamda2*abs([u2(:,i);1]'*l2i);
            d1is(i)=d1i;
            d2is(i)=d2i;
            l1is(:,i)=l1i;
            l2is(:,i)=l2i;
          
            eppErr(i)=d1i+d2i;
     

  end

hold on     
    plot(d1is);
    plot(d2is);
    title('Epipolar error for all points');
    ylabel('epipolar err. [px]');
    xlabel('point index');
    xlim([0 100]);
    ylim([0 250]);
    legend('image 1', 'image 2' );
    fig2pdf( gcf, '09_errorshehe.pdf' );
hold off




load('dat.mat');




