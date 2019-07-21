
img = imread( 'daliborka_01.jpg' ); % load the image
subfig(2,2,1); % create a new figure
image( img ); % display the image, keep axes visible
axis image % display it with square pixels
%[x,y] = ginput(7);
%u = zeros(2,7);
%u(1,:)=x;
%u(2,:)=y;
%save('u.mat','u')
load('u.mat', 'u');

cmap=[255 0 0 0 255 0 0 0 255 255 0 255 0 255 255 255 255 0 255 255 255];


 img(round(u(2,1)),round(u(1,1)),1)=255;
    img(round(u(2,1)),round(u(1,1)),2)=0;
    img(round(u(2,1)),round(u(1,1)),3)=0;

 img(round(u(2,2)),round(u(1,2)),1)=0;
    img(round(u(2,2)),round(u(1,2)),2)=255;
    img(round(u(2,2)),round(u(1,2)),3)=0;
    
    img(round(u(2,3)),round(u(1,3)),1)=0;
    img(round(u(2,3)),round(u(1,3)),2)=0;
    img(round(u(2,3)),round(u(1,3)),3)=255;
    
       img(round(u(2,4)),round(u(1,4)),1)=255;
    img(round(u(2,4)),round(u(1,4)),2)=0;
    img(round(u(2,4)),round(u(1,4)),3)=255;
    
      img(round(u(2,5)),round(u(1,5)),1)=0;
    img(round(u(2,5)),round(u(1,5)),2)=255;
    img(round(u(2,5)),round(u(1,5)),3)=255;
   
    img(round(u(2,6)),round(u(1,6)),1)=255;
    img(round(u(2,6)),round(u(1,6)),2)=255;
    img(round(u(2,6)),round(u(1,6)),3)=0;
    
    
    img(round(u(2,7)),round(u(1,7)),1)=255;
    img(round(u(2,7)),round(u(1,7)),2)=255;
    img(round(u(2,7)),round(u(1,7)),3)=255;
    
  


imwrite(img, '01_daliborka_points.png');



u2 = [   161.9   226.6   244.3   390.4   328.2   443.1   475.6   
         -16.5   -80.3   -90.2  -200.6  -314.9  -328.5  -478.4
     ];     

A = estimate_A( u2, u ); % u2 and u are 2xn matrices
u21 = [   161.9   226.6   244.3   390.4   328.2   443.1   475.6   
         -16.5   -80.3   -90.2  -200.6  -314.9  -328.5  -478.4
         1  1   1   1   1   1   1];   
% assume we have points in ''u'' and points ''u2'' transferred by ''A'' in ''ux''
ux=A*u21;
e = 10 * ( ux - u ); % magnified error displacements
...
hold on % to plot over the image
...
plot( u(1,1), u(2,1), 'o', 'linewidth', 2, 'color', 'red' ) % the 4-th point 
plot( [ u(1,1) u(1,1)+e(1,1) ], [ u(2,1) u(2,1)+e(2,1) ], 'r-', 'linewidth', 2 ); % the 4-th error

plot( u(1,2), u(2,2), 'o', 'linewidth', 2, 'color', 'green' ) % the 4-th point 
plot( [ u(1,2) u(1,2)+e(1,2) ], [ u(2,2) u(2,2)+e(2,2) ], 'r-', 'linewidth', 2 ); % the 4-th error

plot( u(1,3), u(2,3), 'o', 'linewidth', 2, 'color', 'blue' ) % the 4-th point 
plot( [ u(1,3) u(1,3)+e(1,3) ], [ u(2,3) u(2,3)+e(2,3) ], 'r-', 'linewidth', 2 ); % the 4-th error

plot( u(1,4), u(2,4), 'o', 'linewidth', 2, 'color', 'magenta' ) % the 4-th point 
plot( [ u(1,4) u(1,4)+e(1,4) ], [ u(2,4) u(2,4)+e(2,4) ], 'r-', 'linewidth', 2 ); % the 4-th error

plot( u(1,5), u(2,5), 'o', 'linewidth', 2, 'color', 'cyan' ) % the 4-th point 
plot( [ u(1,5) u(1,5)+e(1,5) ], [ u(2,5) u(2,5)+e(2,5) ], 'r-', 'linewidth', 2 ); % the 4-th error

plot( u(1,6), u(2,6), 'o', 'linewidth', 2, 'color', 'yellow' ) % the 4-th point 
plot( [ u(1,6) u(1,6)+e(1,6) ], [ u(2,6) u(2,6)+e(2,6) ], 'r-', 'linewidth', 2 ); % the 4-th error

plot( u(1,7), u(2,7), 'o', 'linewidth', 2, 'color', 'white' ) % the 4-th point 
plot( [ u(1,7) u(1,7)+e(1,7) ], [ u(2,7) u(2,7)+e(2,7) ], 'r-', 'linewidth', 2 ); % the 4-th error
...
hold off


fig2pdf( gcf, '01_daliborka_errs.pdf' )
save( '01_points.mat', 'u', 'A' )



     




