function [K, R, C] = Q2KRC(Q)


m(1)=Q(1, 4);
m(2)=Q(2, 4);
m(3)=Q(3, 4);
m=m.';


M(1, 1:3)=Q(1,1:3);
M(2, 1:3)=Q(2,1:3);
M(3, 1:3)=Q(3,1:3);

M(1, 1:3)=M(1, 1:3).';
M(2, 1:3)=M(2, 1:3).';
M(3, 1:3)=M(3, 1:3).';


m1=M(1, 1:3).';
m2=M(2, 1:3).';
m3=M(3, 1:3).';


norm_m3=norm(m3);

%DET ER EN FORSKJELL PÅ normal division;/ OG     matrix; \


K23=((m2.')*m3)/(norm_m3*norm_m3);
K13=((m1.')*m3)/(norm_m3*norm_m3);
K22=sqrt((((m2.')*m2)/(norm_m3*norm_m3))-K23^2);
K12=((((m1.')*m2)/(norm_m3*norm_m3))-K13*K23)/K22;
K11=sqrt(((m1.')*m1)/(norm_m3*norm_m3)-K12^2-K13^2);

K= [K11 K12 K13;
    0   K22 K23;
    0    0   1 ];


R=(K^(-1))*(sign(det(M))/(norm_m3))*M; 

pixel_size=5*10^(-6);
f=K11*pixel_size;

det(R);

%Betha=[]

C=-inv(M)*m; %represents the position of the camera projection center w.r.t. the world coordinate system
%Q = ? ( K R | - K R C )

%THE BASISES
Delta=eye(3);    %the real world coord has unit vectors
Gamma=Delta*f*inv(R);
Beta=Gamma*inv(K);

Epsilon=Delta*inv(R);
Nu=Epsilon*inv(K);

Kappa=Delta*f;
Alpha=Beta*[1 0; 0 1; 0 0];

test1=(1/f)*K*R ;
test2=-(1/f)*K*R*C;

Pb(:,1)=test1(:, 1);
Pb(:,2)=test1(:, 2);
Pb(:,3)=test1(:, 3);
Pb(:,4)=test2;
Pb;

%THE BASIS CENTRES of the coord. systems expressed in world coord. system
%delta. C is the projection of the camera center i real world coords.
d=zeros(3,1); %the r.w.c is in zero
k=d ;
e=C;
n=C;
b=C ;%is the camera coord. system
g=C;

a=C+Beta(:,3); % is the image center. This is easily shown through page 47

%se side 47 for å finne koordinatene du kan begynne med
save( '03_bases.mat', 'Pb', 'f', 'Alpha', 'a', 'Beta', 'b','Gamma', 'g', 'Delta', 'd', 'Epsilon', 'e', 'Kappa', 'k', 'Nu', 'n', '-v6'  );

% Alpha(:,1)=Alpha(:,1)*1100;
% Alpha(:,2)=Alpha(:,2)*850;
 
% Beta(:,1)=Beta(:,1)*1100;
% Beta(:,2)=Beta(:,2)*850;
%hold on;
%plot_csystem( Delta, d, 'black', 'delta', 0);
%plot_csystem( Epsilon, e, 'magenta', 'epsilon',0 );
%plot_csystem( Kappa, k, 'yellow', 'kappa',0);
%plot_csystem( Nu, n, 'cyan', 'nu',0);
%plot_csystem( Beta, b, 'red', 'beta',50);
% hold off
% fig2pdf( gcf, '03_figure1.pdf' )
% 
% 
% hold on;
% 
% 
%     %a(3)=1;
%     %q=quiver(a, Alpha(:,1), Alpha(:,2),0);
%     %text(Alpha(:,1), Alpha(:,2),  'Alpha' , 'color', 'green' );
%     %c = q.Color;
%     %q.Color = 'green';
% plot_csystem( Gamma, g, 'blue', 'epsilon',0 );
% plot_csystem( Beta, b, 'red', 'beta',0);
% hold off
% fig2pdf( gcf, '03_figure2.pdf' )
% 
% 
% hold on;
% plot_csystem( Delta, d, 'black', 'delta', 0);
% plot_csystem( Epsilon, e, 'magenta', 'epsilon',0 );
% hold off
% fig2pdf( gcf, '03_figure3.pdf' )

end




