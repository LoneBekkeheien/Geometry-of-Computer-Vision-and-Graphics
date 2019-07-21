close all;

u1 =  [0 0 1 1;
      0 1 1 0];
u01 = [1 2 1.5 1;
      1 2 0.5 0];
     % result should be (but verify yourself):
% H =  [1     1     1
%      -1     1     1
%       1     0     1 ];
  
 H = u2H( u1, u01 );

im2 = imread( 'pokemon_00.jpg' ); 
im1 = imread( 'pokemon_06.jpg' ); 
 
%e = [];
%u0 = []; u1 = []; 
%[u,e] = edit_points( { im1, im2 }, { u0, u1 }, e );
%u0 = u{1}; u1 = u{2};

%save( '05_homography.mat', 'u0', 'u1'); 
load('05_homography.mat');

 H = u2h_optim(u,u0);

black_pixels=[];
 [height, width, rgb] = size (im1); 
 k=1;
 for coloum = 1:width
    for row =1:height   
         if (im1(row,coloum,1)==0 && im1(row,coloum,3)==0 && im1(row,coloum,3)==0)
               black_pixels(k,1)=coloum;
               black_pixels(k,2)=row;
               k=k+1;
               
               vec=[row;coloum;1];
               pro=inv(H)*vec;
               pro=pro/pro(3);
               
               %prøv heller å gjør dette punkt for punkt
               
         end    
    end    
 end
 black_pixels(:,3)=1;

 black_pixels_pro=inv(H)*black_pixels.'; % this is the pixels in the reference photo that correspond the pixels from your photo
 black_pixels_pro=black_pixels_pro.';

 
 for i=1:13156
    im1(round(black_pixels(i,1)),round(black_pixels(i,2)),1)=im2(round(black_pixels_pro(i,1)),round(black_pixels_pro(i,2),1));
    im1(black_pixels(i,1),black_pixels(i,2),2)=im1(black_pixels(i,1),black_pixels_pro(i,2),2);
    im1(black_pixels(i,1),black_pixels(i,2),3)=im1(black_pixels(i,1),black_pixels_pro(i,2),3);
 end
 
 imshow(im1)

