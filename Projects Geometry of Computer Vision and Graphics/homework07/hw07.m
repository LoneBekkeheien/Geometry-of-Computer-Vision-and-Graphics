close all;
%-----------------------EXTRACTING VANISHING POINTS------------------------- 
imgs={};
imgs{1} = imread( 'pokemon_06.jpg' ); 
imgs{2} = imread( 'pokemon_45.jpg' );


% u1 = []; u2 = [];
% [u,~] = edit_points( { imgs{1}, imgs{2}}, { u1, u2}, [] );
% u1 = u{1}; u2 = u{2};
% 
% 
% save( '07_dataPoints.mat', 'u1', 'u2'); 
load('07_dataPoints.mat');
u1(3,:)=1;
u2(3,:)=1;

vp1=zeros(3,4);
vp2=zeros(3,4);

lines={};
%-------------VP1-------------------------------
k1=cross(u1(:,2), u1(:,1));
l1=cross(u1(:,3), u1(:,4));
k1(:, 1)=k1(:, 1)./k1(3, 1);
l1(:, 1)=l1(:, 1)./l1(3, 1);
vp1(:, 1)=cross(k1, l1);
vp1(:, 1)=vp1(:, 1)./vp1(3, 1);
lines{1}=k1;
lines{2}=l1;

k1=cross(u1(:,4), u1(:,1));
l1=cross(u1(:,3), u1(:,2));
k1(:, 1)=k1(:, 1)./k1(3, 1);
l1(:, 1)=l1(:, 1)./l1(3, 1);
vp1(:, 2)=cross(k1, l1);
vp1(:, 2)=vp1(:, 2)./vp1(3, 2);
lines{3}=k1;
lines{4}=l1;

k1=cross(u1(:,6), u1(:,5));
l1=cross(u1(:,7), u1(:,8));
k1(:, 1)=k1(:, 1)./k1(3, 1);
l1(:, 1)=l1(:, 1)./l1(3, 1);
vp1(:, 3)=cross(k1, l1);
vp1(:, 3)=vp1(:, 3)./vp1(3, 3);
lines{5}=k1;
lines{6}=l1;


k1=cross(u1(:,8), u1(:,5));
l1=cross(u1(:,7), u1(:,6));
k1(:, 1)=k1(:, 1)./k1(3, 1);
l1(:, 1)=l1(:, 1)./l1(3, 1);
vp1(:, 4)=cross(k1, l1);
vp1(:, 4)=vp1(:, 4)./vp1(3, 4);
lines{7}=k1;
lines{8}=l1;

%-------------VP2-------------------------------
k2=cross(u2(:,2), u2(:,1));
l2=cross(u2(:,3), u2(:,4));
k2(:, 1)=k2(:, 1)./k2(3, 1);
l2(:, 1)=l2(:, 1)./l2(3, 1);
vp2(:, 1)=cross(k2, l2);
vp2(:, 1)=vp2(:, 1)./vp2(3, 1);
lines{9}=k1;
lines{10}=l1;

k2=cross(u2(:,4), u2(:,1));
l2=cross(u2(:,3), u2(:,2));
k2(:, 1)=k2(:, 1)./k2(3, 1);
l2(:, 1)=l2(:, 1)./l2(3, 1);
vp2(:, 2)=cross(k2, l2);
vp2(:, 2)=vp2(:, 2)./vp2(3, 2);
lines{11}=k1;
lines{12}=l1;

k2=cross(u2(:,6), u2(:,5));
l2=cross(u2(:,7), u2(:,8));
k2(:, 1)=k2(:, 1)./k2(3, 1);
l2(:, 1)=l2(:, 1)./l2(3, 1);
vp2(:, 3)=cross(k2, l2);
vp2(:, 3)=vp2(:, 3)./vp2(3, 3);
lines{13}=k1;
lines{14}=l1;


k2=cross(u2(:,8), u2(:,5));
l2=cross(u2(:,7), u2(:,6));
k2(:, 1)=k2(:, 1)./k2(3, 1);
l2(:, 1)=l2(:, 1)./l2(3, 1);
vp2(:, 4)=cross(k2, l2);
vp2(:, 4)=vp2(:, 4)./vp2(3, 4);
lines{15}=k1;
lines{16}=l1;

%---------------------------07_vp1.pdf----------------
hold on
img1 = imgs{1};
image( img1 ); 
axis image

set(gca,'YDir','reverse');
plot(vp1(1,1), vp1(2,1),'rx');
plot(vp1(1,2), vp1(2,2),'rx');
plot(vp1(1,3), vp1(2,3),'bx');
plot(vp1(1,4), vp1(2,4),'bx');

plot([u1(1,1) vp1(1,1)], [u1(2,1), vp1(2,1)],'r-')
plot([u1(1,4) vp1(1,1)], [u1(2,4), vp1(2,1)],'r-')
plot([u1(1,2) vp1(1,2)], [u1(2,2), vp1(2,2)],'r-')
plot([u1(1,1) vp1(1,2)], [u1(2,1), vp1(2,2)],'r-')
plot([u1(1,5) vp1(1,3)], [u1(2,5), vp1(2,3)],'b-')
plot([u1(1,8) vp1(1,3)], [u1(2,8), vp1(2,3)],'b-')
plot([u1(1,6) vp1(1,4)], [u1(2,6), vp1(2,4)],'b-')
plot([u1(1,5) vp1(1,4)], [u1(2,5), vp1(2,4)],'b-')
plot([vp1(1,2) vp1(1,3)], [vp1(2,2), vp1(2,3)],'g-')
hold off
fig2pdf( gcf, '07_vp1.pdf' );


%---------------------------07_vp2.pdf----------------
hold on
img2 = imgs{2};
image( img2 );
axis image 
set(gca,'YDir','reverse');
plot(vp2(1,1), vp2(2,1),'rx');
plot(vp2(1,2), vp2(2,2),'rx');
plot(vp2(1,3), vp2(2,3),'bx');
plot(vp2(1,4), vp2(2,4),'bx');
plot([vp2(1,1) vp2(1,4)], [vp2(2,1), vp2(2,4)],'g-')
plot([u2(1,4) vp2(1,2)], [u2(2,4), vp2(2,2)],'r-')
plot([u2(1,5) vp2(1,3)], [u2(2,5), vp2(2,3)],'b-')
plot([u2(1,8) vp2(1,3)], [u2(2,8), vp2(2,3)],'b-')
plot([u2(1,8) vp2(1,4)], [u2(2,8), vp2(2,4)],'b-')
plot([u2(1,7) vp2(1,4)], [u2(2,7), vp2(2,4)],'b-')
plot([u2(1,1) vp2(1,1)], [u2(2,1), vp2(2,1)],'r-')
plot([u2(1,4) vp2(1,1)], [u2(2,4), vp2(2,1)],'r-')
plot([u2(1,3) vp2(1,2)], [u2(2,3), vp2(2,2)],'r-')

hold off
fig2pdf( gcf, '07_vp2.pdf' );



% img = imgs{1};
% subfig(2,2,1);
% image(img);
% hold on
% line(u1(1:2,3), u1(1:2,4));
% line(u1(1:2,2), u1(1:2,1));
% line(u1(1:2,3), vp1(1:2,1));
% line(u1(1:2,2), vp1(1:2,1));
% %line(u1(1:2,1), vp1(1:2,1));
% %set(gca, 'XLim',[-2000  2000])
% %set(gca, 'YLim',[-12000  100])
% %xlim([-2000 2000]);
% %ylim([-12000 100]);
% hold off

%fig2pdf( gcf, '07_vp1.pdf' );
%fig2pdf( gcf, '07_vp2.pdf' );

%fig2pdf( gcf, '07_vp1_zoom.pdf');
%fig2pdf( gcf, '07_vp2_zoom.pdf');

%---------------------------07_vp1_zoom.pdf----------------

hold on
img1 = imgs{1};
image( img1 ); 
axis image 

set(gca,'YDir','reverse');
plot(vp1(1,3), vp1(2,3),'bx');
plot(vp1(1,1), vp1(2,1),'rx');
plot(vp1(1,4), vp1(2,4),'bx');
plot(vp1(1,2), vp1(2,2),'rx');

plot([u1(1,1) vp1(1,2)], [u1(2,1), vp1(2,2)],'r-')
plot([u1(1,1) vp1(1,1)], [u1(2,1), vp1(2,1)],'r-')
plot([u1(1,4) vp1(1,1)], [u1(2,4), vp1(2,1)],'r-')
plot([u1(1,6) vp1(1,4)], [u1(2,6), vp1(2,4)],'b-')
plot([u1(1,5) vp1(1,4)], [u1(2,5), vp1(2,4)],'b-')

plot([vp1(1,2) vp1(1,3)], [vp1(2,2), vp1(2,3)],'g-')
plot([u1(1,2) vp1(1,2)], [u1(2,2), vp1(2,2)],'r-')


plot([u1(1,5) vp1(1,3)], [u1(2,5), vp1(2,3)],'b-')
plot([u1(1,8) vp1(1,3)], [u1(2,8), vp1(2,3)],'b-')


xlim([-200 1400])
ylim([-200 1200])
hold off
fig2pdf( gcf, '07_vp1_zoom.pdf' );
close all

%---------------------------07_vp2_zoom.pdf----------------
hold on
img2 = imgs{2};
image( img2);
axis image %

set(gca,'YDir','reverse');
plot(vp2(1,1), vp2(2,1),'rx');
plot(vp2(1,3), vp2(2,3),'bx');
plot(vp2(1,4), vp2(2,4),'bx');
plot(vp2(1,2), vp2(2,2),'rx');


plot([u2(1,5) vp2(1,3)], [u2(2,5), vp2(2,3)],'b-')
plot([u2(1,8) vp2(1,3)], [u2(2,8), vp2(2,3)],'b-')
plot([u2(1,1) vp2(1,1)], [u2(2,1), vp2(2,1)],'r-')
plot([u2(1,4) vp2(1,1)], [u2(2,4), vp2(2,1)],'r-')
plot([u2(1,8) vp2(1,4)], [u2(2,8), vp2(2,4)],'b-')
plot([u2(1,7) vp2(1,4)], [u2(2,7), vp2(2,4)],'b-')
plot([u2(1,3) vp2(1,2)], [u2(2,3), vp2(2,2)],'r-')
plot([u2(1,4) vp2(1,2)], [u2(2,4), vp2(2,2)],'r-')




plot([vp2(1,1) vp2(1,4)], [vp2(2,1), vp2(2,4)],'g-')
xlim([-200 1400])
ylim([-200 1200])
hold off
fig2pdf( gcf, '07_vp2_zoom.pdf' );
close all
%-------------------------------------CALIBRATION--------------

    
V1=[vp1(1,4) vp1(1,2) vp1(1,3)]
V2=[vp2(2,4) vp2(2,2) vp2(2,3)]
o13=-(V2(1)*V1(1)+V2(2)*V1(2))/(V2(3)*V1(1)+V2(1)*V1(3));
o23=-(V2(1)*V1(1)+V2(2)*V1(2))/(V2(3)*V1(2)+V2(2)*V1(3));
o33=-(V2(1)*V1(1)+V2(2)*V1(2))/(V2(3)*V1(3));

k13=-o13;
k23=-o23;
k11=sqrt(o33-(k13)^2-k23^2);
k12=0;
k22=k11;
K=[k11 k12 k13;
    0 k22 k23;
    0 0    1];

K=real(K);

Kinv=inv(K);
angels={};
for i=1:4
    l1=lines{i};
    l2=lines{i+8};
    angels{i}=acos((l1'*Kinv'*Kinv*l2)/(norm(Kinv*l1)*norm(Kinv*l2)));
end    


angle=mean([angels{1} angels{2} angels{3} angels{4}]);


R1=[1 0 0;
    0 1 0;
    0 0 1];
R2 = [1 0 0;
      0 1 0;
      0 0 1];
C1 =[1 1 1]';
C2=[1 1 1]';



%--------------------------------------VIRTUAL OBJECT-----------


%--------------------------------------SAVE ALL DATA------------
u1(3,:)=[];
u2(3,:)=[];
vp1(3,:)=[];
vp2(3,:)=[];


save('07_data.mat', 'u1', 'u2', 'vp1', 'vp2', 'K', 'angle', 'C1', 'C2', 'R1', 'R2');
