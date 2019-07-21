close all;
imgs={};
imgs{1} = imread( 'daliborka_01.jpg' ); 
imgs{2} = imread( 'daliborka_23.jpg' );


K= [2487.3274086528036	-1.0458236470401807	566.738985409248
3.631496054503253E-14	2487.1707706865295	414.5207938844943
0.0	-7.092765731451665E-17	1.0
];

load('08_data.mat');

%-----------------------EX AND FX---------------------------
point_sel=[43    24    18     9    40    36     6    33    16    34     7    48];
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
         
figure(1);
hold on     
    plot(d1is);
    plot(d2is);
    title('Epipolar error for all points');
    ylabel('epipolar err. [px]');
    xlabel('point index');
    legend('image 1', 'image 2' );
    fig2pdf( gcf, '09_errorsx.pdf' );
hold off

figure(2);
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

fig2pdf( gcf, '09_egx.pdf' );

%----------------------------E AND Fe-----------------------
 inds=nchoosek(1:12,8)+40;

    maxeppErr=[];
    Gs={};
    Fs={};
    Fes={};
    Es={};
    for j=1:size(inds, 1)

       u1test=u1(:,inds(j,:));
       u2test=u2(:,inds(j,:));
       
        [Fj, Gj] = u2FG( u1test, u2test );
        %Es{j} = K' * Fj * K;
        %Fes{j}=inv(K)'*Es{j}*inv(K);
        Fs{j}=Fj;
        Gs{j}=Gj;
        
        Es{j} = K' * Fj * K;
        [U D V] = svd( Es{j} ); 
        D(2,2) = D(1,1);
        Es{j} = U * D * V';
        Fes{j}=inv(K)'*Es{j}*inv(K);

     
          for i=1:52
         
            l1i=Fj'*[u2(:,i);1];
            lamda1=1/sqrt(l1i(1)^2+l1i(2)^2);
            l2i=Fj*[u1(:,i);1];
            lamda2=1/sqrt(l2i(1)^2+l2i(2)^2);
            d1i=lamda1*abs([u1(:,i);1]'*l1i); %should be dot product
            d2i=lamda2*abs([u2(:,i);1]'*l2i);
        
       
            eppErr(i)=d1i+d2i;

          end
   
            maxeppErr(j)=max(eppErr);
       
    end
    [ek, index]=min(maxeppErr);
    maxeppErr(index)
    F=Fs{index};
    G=Gs{index};
    Fe=Fes{index};
    E=Es{index};
    rank(F)
    
    
    for i=1:52
         
            l1i=Fe'*[u2(:,i);1];
            lamda1=1/sqrt(l1i(1)^2+l1i(2)^2);
            l2i=Fe*[u1(:,i);1];
            lamda2=1/sqrt(l2i(1)^2+l2i(2)^2);
            d1i=lamda1*abs([u1(:,i);1]'*l1i); %should be dot product
            d2i=lamda2*abs([u2(:,i);1]'*l2i);
            d1isFe(i)=d1i;
            d2isFe(i)=d2i;
            l1is(:,i)=l1i;
            l2is(:,i)=l2i;
          
            eppErr(i)=d1i+d2i;
     

  end
         
figure(3);  
hold on     
    plot(d1isFe);
    plot(d2isFe);
    title('Epipolar error for all points');
    ylabel('epipolar err. [px]');
    xlabel('point index');
    legend('image 1', 'image 2' );
    fig2pdf( gcf, '09_errors.pdf' );
hold off

figure(4);
subplot(1,3,1);
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

subplot(1,3,2);
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

fig2pdf( gcf, '09_eg.pdf' );

    





save('09a_data.mat', 'F', 'Ex', 'Fx', 'E', 'Fe', 'u1', 'u2', 'point_sel');