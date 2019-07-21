%--------------------------PROJECTION MATRIX OF PERSPECTIVE CAMERA---------
close all;
IX = [ 11 91 57 14 7 13 68 51 102 97 ];
load( 'daliborka_01-ux.mat' ); % loads all variables from the file into the workspace
img = imread( 'daliborka_01.jpg' );


subfig(2,2,1); % create a new figure
image( img ); % display the image, keep axes visible
plot3( x(1,:), x(2,:), x(3,:) )
axis equal
%axis image % display it with square pixels
u(3,:)=1;
[Q, points_sel, err_max,err_max_all, Q_all, sel_index]  = estimate_Q( u, x, IX );

%-----------------------------------PLOT 5--------------------------
plot(1: length (err_max_all),log10(err_max_all))  %SKJØNNER IKKE OM DET SKAL VÆRE ALLE ELLER BARE DEN ENE

xlabel('Selection index');
ylabel('log_10 of max. reproj.err.[px]');
title('Maximal reproj. err. for each tested Q');
xlim([0 2520])
fig2pdf( gcf, '02_Q_maxerr.pdf' );



%-----------------------------------PLOT 6--------------------------

image( img );
hold on; % without this, the next drawing command would clear the figure

%x(4,:)=1;
%x_pro=Q*x;
%x(4,:)=[];

plot( u(1,:), u(2,:), '.' );
plot(u(1,points_sel(1)), u(2,points_sel(1)), '.', 'color', 'yellow'); 
plot( u(1,:), u(2,:), 'o', 'linewidth', 1, 'color', 'red' ) % SKJØNNER IKKE HVA SOM SKAL VÆRE HER ISTEDENFOR U 

plot(u(1,points_sel(2)), u(2,points_sel(2)), '.', 'color', 'yellow'); 
plot(u(1,points_sel(3)), u(2,points_sel(3)), '.', 'color', 'yellow'); 
plot(u(1,points_sel(4)), u(2,points_sel(4)), '.', 'color', 'yellow'); 
plot(u(1,points_sel(5)), u(2,points_sel(5)), '.', 'color', 'yellow'); 
plot(u(1,points_sel(6)), u(2,points_sel(6)), '.', 'color', 'yellow'); 

xlabel('x[px]');
ylabel('y[px]');
title('Original and reprojected points');
legend('Orig.pts', 'Used for Q', 'Reprojected');
xlim([0 1000])

hold off
axis equal

fig2pdf( gcf, '02_Q_projections.pdf' )

%-----------------------------------------PLOT 7------------------

image( img );
hold on % to plot over the image
plot( u(1,:), u(2,:), '.' );
plot(u(1,points_sel(1)), u(2,points_sel(1)), '.', 'color', 'yellow'); 

x(4,:)=1;
x_pro=Q*x;
x(4,:)=[];


e = 100 * ( x_pro - x );
for i=1:1:109
plot( [ u(1,i) u(1,i)+e(1,i) ], [ u(2,i) u(2,i)+e(2,i) ], 'r-', 'linewidth', 1 ); % the 4-th error
end


plot(u(1,points_sel(2)), u(2,points_sel(2)), '.', 'color', 'yellow'); 
plot(u(1,points_sel(3)), u(2,points_sel(3)), '.', 'color', 'yellow'); 
plot(u(1,points_sel(4)), u(2,points_sel(4)), '.', 'color', 'yellow'); 
plot(u(1,points_sel(5)), u(2,points_sel(5)), '.', 'color', 'yellow'); 
plot(u(1,points_sel(6)), u(2,points_sel(6)), '.', 'color', 'yellow'); 


x(4,:)=1;
x_pro=Q*x;
x(4,:)=[];


xlabel('x[px]');
ylabel('y[px]');
title('Reprojection errors(100x enlarged)');
legend('Orig.pts', 'Used for Q', 'Errors(100x)');
xlim([0 1000])

hold off
axis equal

fig2pdf( gcf, '02_Q_projections_errors.pdf' )

%--------------------------------------------PLOT 8--------------

 x(4,:)=1;
            x_pro=Q*x; %the projection of 3D points x
            for j=1:1:109
                eij=sqrt((x_pro(1,j)-u(1,j)).^2+(x_pro(2,j)-u(2,j)).^2); %eucl. distance between measured points u and the projection of 3D points x 
                euclErr(j)=eij; 
            end

plot(1: length(euclErr), euclErr) 
xlabel('point index');
ylabel('reproj.err[px]');
title('All point reproj. errors for the best Q');
xlim([0 109])
fig2pdf( gcf, '02_Q_pointerr.pdf' )



