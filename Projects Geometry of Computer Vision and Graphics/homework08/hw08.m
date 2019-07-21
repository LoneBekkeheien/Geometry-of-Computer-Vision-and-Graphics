close all;


imgs={};
imgs{1} = imread( 'daliborka_01.jpg' ); 
imgs{2} = imread( 'daliborka_23.jpg' );


% u1_12 = []; u2_12 = [];
% [u,~] = edit_points( { imgs{1}, imgs{2}}, { u1_12, u2_12}, [] );
% u1_12 = u{1}; u2_12 = u{2};
% save( '52_pointsLone.mat', 'u1', 'u2'); 
% load('12_points.mat');
%load('08_dataPoints1.mat');
%load('08_12cor.mat')
% u1_12=u1;
% u2_12=u2;
%load('08_dataPoints1.mat');

%load('08_40cor.mat')

% u1=[u1 u1_12];
% u2=[u2 u2_12];
load('52cor_points.mat');
%load('52_pointsLone.mat')
point_sel=[1 13 3 4 20 6 52 17 9 27 36 42];
k=1;
A=zeros(8,9);
 inds=nchoosek(1:12,8)+40;

    maxeppErr=[];
    Gs={};
    Fs={};
    for j=1:size(inds, 1)

       u1test=u1(:,inds(j,:));
       u2test=u2(:,inds(j,:));
       
        [Fj, Gj] = u2FG( u1test, u2test );
        Fs{j}=Fj;
        Gs{j}=Gj;
     
          for i=1:52
         
            l1i=Fj'*[u2(:,i);1];
            lamda1=1/sqrt(l1i(1)^2+l1i(2)^2);
            l2i=Fj*[u1(:,i);1];
            lamda2=1/sqrt(l2i(1)^2+l2i(2)^2);
            d1i=lamda1*abs([u1(:,i);1]'*l1i); %should be dot product
            d2i=lamda2*abs([u2(:,i);1]'*l2i);
        
            k=k+1;
            eppErr(i)=d1i+d2i;

          end
   
            maxeppErr(j)=max(eppErr);
       
    end
    [ek, index]=min(maxeppErr);
    maxeppErr(index)
    F=Fs{index};
    G=Gs{index};
    rank(F)

%load('12_points.mat');
save( '08_data.mat', 'u1', 'u2', 'G', 'F', 'point_sel');
save('F_from_hw08.mat', 'F');
d1is=[];
d2is=[];
 
         for i=1:52
         
            l1i=F'*[u2(:,i);1];
            lamda1=1/sqrt(l1i(1)^2+l1i(2)^2);
            l2i=F*[u1(:,i);1];
            lamda2=1/sqrt(l2i(1)^2+l2i(2)^2);
            d1i=lamda1*abs([u1(:,i);1]'*l1i); %should be dot product
            d2i=lamda2*abs([u2(:,i);1]'*l2i);
            d1is(i)=d1i;
            d2is(i)=d2i;
            l1is(:,i)=l1i;
            l2is(:,i)=l2i;
            k=k+1;
            eppErr(i)=d1i+d2i;
     

         end
    hold on     
            plot(d1is);
            plot(d2is);
            title('Epipolar error for all points');
ylabel('epipolar err. [px]');
xlabel('point index');
legend('image 1', 'image 2' );
fig2pdf( gcf, '08_errors.pdf' );
hold off

close all;


subplot(1,2,1);
hold on;
imshow(imgs{1});
plot(u1(1,point_sel(1)), u1(2,point_sel(1)),'bx', 'LineWidth', 2);
plot(u1(1,point_sel(2)), u1(2,point_sel(2)),'rx', 'LineWidth', 2);
plot(u1(1,point_sel(3)), u1(2,point_sel(3)),'yx', 'LineWidth', 2);
plot(u1(1,point_sel(4)), u1(2,point_sel(4)),'gx', 'LineWidth', 2);
plot(u1(1,point_sel(5)), u1(2,point_sel(5)),'cx', 'LineWidth', 2);
plot(u1(1,point_sel(6)), u1(2,point_sel(6)),'bx', 'LineWidth', 2);
plot(u1(1,point_sel(7)), u1(2,point_sel(7)),'rx', 'LineWidth', 2);
plot(u1(1,point_sel(8)), u1(2,point_sel(8)),'yx', 'LineWidth', 2);
plot(u1(1,point_sel(9)), u1(2,point_sel(9)),'gx', 'LineWidth', 2);
plot(u1(1,point_sel(10)), u1(2,point_sel(10)),'cx', 'LineWidth', 2);
plot(u1(1,point_sel(11)), u1(2,point_sel(11)),'bx', 'LineWidth', 2);
plot(u1(1,point_sel(12)), u1(2,point_sel(12)),'rx', 'LineWidth', 2);

for i=1:12
    
   a=l1is(1,point_sel(i));
   b=l1is(2,point_sel(i));
   c=l1is(3,point_sel(i));
   x=1:1100;
   y=(-c-a*x)/b;
   plot(x,y);
   set(gca, 'YLim', [1, 1100]);
end    

subplot(1,2,2);
hold on;
imshow(imgs{2});
plot(u2(1,point_sel(1)), u2(2,point_sel(1)),'bx', 'LineWidth', 2);
plot(u2(1,point_sel(2)), u2(2,point_sel(2)),'rx', 'LineWidth', 2);
plot(u2(1,point_sel(3)), u2(2,point_sel(3)),'yx', 'LineWidth', 2);
plot(u2(1,point_sel(4)), u2(2,point_sel(4)),'gx', 'LineWidth', 2);
plot(u2(1,point_sel(5)), u2(2,point_sel(5)),'cx', 'LineWidth', 2);
plot(u2(1,point_sel(6)), u2(2,point_sel(6)),'bx', 'LineWidth', 2);
plot(u2(1,point_sel(7)), u2(2,point_sel(7)),'rx', 'LineWidth', 2);
plot(u2(1,point_sel(8)), u2(2,point_sel(8)),'yx', 'LineWidth', 2);
plot(u2(1,point_sel(9)), u2(2,point_sel(9)),'gx', 'LineWidth', 2);
plot(u2(1,point_sel(10)), u2(2,point_sel(10)),'cx', 'LineWidth', 2);
plot(u2(1,point_sel(11)), u2(2,point_sel(11)),'bx', 'LineWidth', 2);
plot(u2(1,point_sel(12)), u2(2,point_sel(12)),'rx', 'LineWidth', 2);
for i=1:12
   a=l2is(1,point_sel(i));
   b=l2is(2,point_sel(i));
   c=l2is(3,point_sel(i));
   x=1:1100;
   y=(-c-a*x)/b;
   plot(x,y);
   set(gca, 'YLim', [1, 1100]);
end     
hold off

fig2pdf( gcf, '08_eg.pdf' );

