function H = u2h_optim(u, u0)
    H=[];
    
    IX=[];
    for i=1:8
        IX(i)=i;
    end     
 
    C = nchoosek(IX,4);

    for j=1:size(C)
        ind=C(j,:);
        u2=u(:,ind);
        u02=u0(:,ind);
        
        H=u2H(u2, u02);  
        H_matrices{j}=H;
        PointsForMatrix{j}=ind;
        
         
        
        for i=1:8
            ui=u(:,i);
            ui(3)=1;
            u_pro=H*ui; %the projection of 3D points x
            u_pro(1)=u_pro(1)./u_pro(3); %have to do this to make this point be on the image. The image is in 2D, and the camera is in 3D, so we want to divide by x3 to get one on the Z, and altså to get the right numbers
            u_pro(2)=u_pro(2)./u_pro(3); %DO NOT FORGET TO ./ INSTEAD OF JUST / !!!!
            u_pro(3)=u_pro(3)./u_pro(3);
           
            eij=norm(u_pro-[u0(:,i); 1]); %eucl. distance between measured points u and the projection of 3D points x 
            euclErr(i)=eij; 
        end    
        
        maxTransfErr(j)=max(euclErr);
        
        
  
    end
    
    [ek, index]=min(maxTransfErr);
    sel_index=PointsForMatrix;
    H = H_matrices{index}; 
    err_max=maxTransfErr;
    point_sel=PointsForMatrix{index};
   
    
    save( '05_homography.mat', 'H', 'u', 'u0', 'point_sel');
   
 
        
       
  end   

