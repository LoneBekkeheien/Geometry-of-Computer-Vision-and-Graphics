function [F, G] = u2FG( u11, u21 )

    
  
         mean1=mean(u11,2);
         std1=std(u11,[],2);
         mean2=mean(u21,2);
         std2=std(u21,[],2);
         H1=[1/std1(1) 0 -mean1(1)/std1(1);
             0 1/std1(2) -mean1(2)/std1(2);
                0 0 1 ];
                
                 H2=[1/std2(1) 0 -mean2(1)/std2(1);
             0 1/std2(2) -mean2(2)/std2(2);
                0 0 1 ];  
        
         u11(3,:)=1;
         u21(3,:)=1;
         u1n=H1*u11;
         u2n=H2*u21;
         
%          u1n=u1n./u1n(3,:);
%          u2n=u2n./u2n(3,:);
        
       for i=1:8
           % i=inds(j,k);   
           An(i,:)=[u2n(1,i)*u1n(1,i) u2n(1,i)*u1n(2,i) u2n(1,i)*1 u2n(2,i)*u1n(1,i) u2n(2,i)*u1n(2,i) u2n(2,i)*1 1*u1n(1,i) 1*u1n(2,i) 1];    
        end


        gn = null(An);

%         Gn = [
%             gn(1:3)';
%             gn(4:6)';
%             gn(7:9)';
%         ];  %WHAT IS THIS??
        Gn=reshape(gn,3,3)';
        
         
    
   
        [S,V,D]=svd(Gn);
        V(3,3)=0;
        Fn=S*V*D';
        G=H2'*Gn*H1;
        F=H2'*Fn*H1;    
        
      
       
  
    end
 
 
    

   

 
