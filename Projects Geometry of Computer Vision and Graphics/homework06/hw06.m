close all;


%--------------GIVEN DATA
ExifImageWidth = 2400;
ExifImageHeight = 1800;
FocalPlaneXResolution = 2160000/225;
FocalPlaneYResolution = 1611200/168;
FocalLength = 7400/1000;


imgs={};
imgs{1} = imread( 'bridge_01.jpg' ); 
imgs{2} = imread( 'bridge_02.jpg' );

imgs{3} = imread( 'bridge_03.jpg' ); 
imgs{4} = imread( 'bridge_04.jpg' );

imgs{5} = imread( 'bridge_05.jpg' ); 
imgs{6} = imread( 'bridge_06.jpg' );

imgs{7}= imread( 'bridge_07.jpg' );



% 
% for i=1:6
%     u0 = []; u1 = []; e=[];
%    [u,e] = edit_points( { imgs{i}, imgs{i+1}}, { u0, u1}, [] );
%     u0 = u{1}; u1 = u{2};
%     
%     matrise{i,i+1}=u0;
%     matrise{i+1,i}=u1;
%     
%     save( '06_data.mat', 'matrise'); 
% end
load('06_data.mat');

for i=1:6
    H_mats{i,i+1} = u2h_optim(u{i,i+1},u{i+1,i}); 
   % H_mats{i+1,i} = u2h_optim(u{i,i+1},u{i+1,i}); 
    
end    

H=H_mats;

for i = 1:6 
    U = u{i,i+1};
    U0 = u{i+1,i};
    Horig = H{i,i+1};
    sizeUs = size(U);
        
    for l = 1:sizeUs(2)
        Uorig = U(:, l);
        U0or = [U0(:, l); 1];
        U0orig = Horig*[Uorig; 1];
        U0orig = U0orig/U0orig(3);
        Errorig = U0orig-U0or;
        Errorig=norm( Errorig);
        error(l, i) = Errorig;
    end
end



hist(error);

set(gca,'YTick',0:10);
title('Histogram of transfer errors');
xlabel('err [px]');
ylabel('count');
fig2pdf( gcf, '06_histograms.pdf' );


H_mats{2,4} = H_mats{3,4}*H_mats{2,3}; 
H_mats{1,4} = H_mats{2,4}*H_mats{1,2};
H_mats{5,4} = inv(H_mats{4,5});  %when we already have H{5,4} we can take the inverse to get the oposite
H_mats{6,4} = inv(H_mats{5,6})*H_mats{5,4};  %why does this work??
H_mats{7,4} = inv(H_mats{6,7})*H_mats{6,4};
v=[1 1 1];
H_mats{4,4} = diag(v);  %hompgraphy from the same image will be the identity

for h = 1:7
    
    H_mats{4,h} = 1\H_mats{h,4};
    
end


subfig(2,2,1);




%----------constructing the K matrix

inch2mm=25.4;

K = [
    FocalLength*FocalPlaneXResolution/(inch2mm*2)      0      ExifImageWidth/(2*2);
    0         FocalLength*FocalPlaneYResolution/(inch2mm*2)   ExifImageHeight/(2*2);
    0             0       1 
];


save( '06_data.mat', 'u', 'H_mats', 'K');

%--------------------PLOTTING BORDERS-------------

subfig(2,2,1);

borders_plotting(H{2,4}, '2');
borders_plotting(H{3,4}, '3');
borders_plotting(H{4,4}, '4');
borders_plotting(H{5,4}, '5');
borders_plotting(H{6,4}, '6');
axis equal;
set(gca,'Ydir','reverse');
fig2pdf( gcf, '06_borders.pdf' );

%------------PLOT PANORAMA IMG PNG------------
subfig(2,2,1);
hold on;
vector_min = [1000000 1000000];
vector_max = [-10000000 -10000000];
gain = diag([0.45 0.25 1]);
for i = 3:5
    actualH = gain*H{i,4};   
    
      pxAr = [];
      px = actualH*[0; 0; 1];
      pxAr = [pxAr px];
      px = actualH*[ExifImageWidth/2-1; 0; 1];
      pxAr = [pxAr px];
      px = actualH*[0; ExifImageHeight/2-1; 1];
      pxAr = [pxAr px];
      px = actualH*[ExifImageWidth/2-1; ExifImageHeight/2-1;  1];
      pxAr = [pxAr px];
      s = size(pxAr,2);
      for j=1:s
            
            px =pxAr(:,j);
            px = px/px(3);
            vector_min(1) = round(min([vector_min(1) px(1)]));
            vector_min(2) = round(min([vector_min(2) px(2)]));
            
            vector_max(1) = round(max([vector_max(1) px(1)]));
            vector_max(2) = round(max([vector_max(2) px(2)]));
    
   
         end   
            
     


end;



ps = vector_max-vector_min;
ps(1) = round(ps(1));
ps(2) = round(ps(2));

pImg = zeros(ps(2), ps(1), 3, 'uint8');

for i = 3:5
    actualH = gain*H{i,4};     
    
    for j=1:1800/2
        for k=1:2400/2
              color=imgs{i}(j,k,:);
              px=actualH*[ k;j; 1];
              px=px(1:2)/px(3);
           
              try
                  c = round(px(2)-vector_min(2)+5);
                  d = round(px(1)-vector_min(1)+5);
                  
              pImg(round(px(2)-vector_min(2)+5), round(px(1)-vector_min(1)+5), :) = color; 
              catch e
                  g=0
              end;
        end;
    end;
    
 


end;
set(gca,'Ydir','reverse');
axis image;
image(pImg);
imwrite( pImg, '06_panorama.png' );

