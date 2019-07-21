function [Q, points_sel, err_max,err_max_all, Q_all, sel_index] = estimate_Q( u, x, ix)


    C = nchoosek(ix,6);
    l=0;
    for i=1:1:210
        for j=1:1:6
           
            Mi(j,1)=x(1,C(i,j));
            Mi(j,2)=x(2,C(i,j));
            Mi(j,3)=x(3,C(i,j));
            Mi(j,4)=1;
            
            Mi(j,9)=-u(1,C(i,j))*x(1,C(i,j));
            Mi(j,10)=-u(1,C(i,j))*x(2,C(i,j));
            Mi(j,11)=-u(1,C(i,j))*x(3,C(i,j));
            Mi(j,12)=-u(1,C(i,j));
            
           
            Mi(j+6,5)=x(1,C(i,j));
            Mi(j+6,6)=x(2,C(i,j));
            Mi(j+6,7)=x(3,C(i,j));
            Mi(j+6,8)=1;
            
            Mi(j+6,9)=-u(2,C(i,j))*x(1,C(i,j));
            Mi(j+6,10)=-u(2,C(i,j))*x(2,C(i,j));
            Mi(j+6,11)=-u(2,C(i,j))*x(3,C(i,j));
            Mi(j+6,12)=-u(2,C(i,j));
            
            M_matrices{i}=Mi;
           
           
        end
              for h=1:1:12 
                 l=l+1;
                 FinalM_matrices{i}= M_matrices{i};
                 FinalM_matrices{i}(h,:)=[];  
                 All_M_matrices{l}=FinalM_matrices{i};
                 PointsForMatrix{l}=[C(i,1) C(i,2) C(i,3) C(i,4) C(i,5) C(i,6)];
              end
    end
            %need to find a way to check this for deleting each row
     for i=1:1:2520  
           
            Q1=null(All_M_matrices{i});
            QReshape{i}=reshape(Q1,[4,3]).';
            
           
            x(4,:)=1;
            x_pro=QReshape{i}*x; %the projection of 3D points x
            x_pro(1,:)=x_pro(1,:)./x_pro(3,:); %have to do this to make this point be on the image. The image is in 2D, and the camera is in 3D, so we want to divide by x3 to get one on the Z, and altså to get the right numbers
            x_pro(2,:)=x_pro(2,:)./x_pro(3,:); %DO NOT FORGET TO ./ INSTEAD OF JUST / !!!!
            x_pro(3,:)=x_pro(3,:)./x_pro(3,:);
        
            
            for j=1:1:109
                eij=sqrt((x_pro(1,j)-u(1,j)).^2+(x_pro(2,j)-u(2,j)).^2); %eucl. distance between measured points u and the projection of 3D points x 
                euclErr(j)=eij; 
            end
            
             maxTransfErr(i)=max(euclErr);
            
     end
   
    [ek, index]=min(maxTransfErr);
    sel_index=PointsForMatrix;
    Q = QReshape{index}; 
    err_max=maxTransfErr;
    Q_all=QReshape;
    points_sel=PointsForMatrix{index};
    
    err_max_all=maxTransfErr;
    indeks=1;
    for k=1:1:210
        if(C(k, 1)== points_sel(1) && C(k, 2)== points_sel(2) && C(k, 3)== points_sel(3) && C(k, 4)== points_sel(4) && C(k, 5)== points_sel(5) && C(k, 6)== points_sel(6))
            indeks=k;
        end
    end
    


end