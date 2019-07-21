function A_matrix = estimate_A(u2,u)
 
    n = size(u,2); % number of columns
    rn = zeros(35,3);
    rn=nchoosek(1:n, 3);
  
          u2 = [   161.9   226.6   244.3   390.4   328.2   443.1   475.6   
         -16.5   -80.3   -90.2  -200.6  -314.9  -328.5  -478.4
         1  1   1   1   1   1   1]; 
   
    for i=1:1:35
       
        ui(:,1)=u(:,rn(i,1));
        ui(:,2)=u(:,rn(i,2));
        ui(:,3)=u(:,rn(i,3));
      
    
        
        u2i(:,1)=u2(:,rn(i,1));
        u2i(:,2)=u2(:,rn(i,2));
        u2i(:,3)=u2(:,rn(i,3));
        u2i(3,:)=1;
      

       Ai=ui/u2i;
       Amatrices{i}=Ai;
  
       u_est=Ai*u2;
       
       %ei=max((u_est-u)^2)  %find minimum of the ei
       for j=1:1:7
           eij=sqrt(u_est(1,j)-u(1,j)+u_est(2,j)-u(2,j));
           euclErr(j)=eij;
            
       end
        %eij=sqrt((u_est(1,:)-u(1,:)).^2+(u_est(2,:)-u(2,:)).^2);
        %euclErr=max(eij);  
        maxTransfErr(i)=max(euclErr);
       
       
    end
   % maxTransfErr
   %euclErr
    
    ek=min(maxTransfErr);
    result = find(maxTransfErr==ek);
    A_matrix = Amatrices{result}; 
end
