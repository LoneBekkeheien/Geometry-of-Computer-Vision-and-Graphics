function [Q, points_sel, err_max, err_points, Q_all] = estimate_Q( u, x, ix )
% x = 3D points, u = 2D points
n = length(ix);
% chose all combinations of 6tiples n = 10
comb = nchoosek(ix, 6);


err_points = [];
err_max = [];
% points_sel = [];
Q_all = zeros([3 4 length(comb)*12]);
points_sel = [];
helpPointsSel = zeros([6 length(comb)*12]);
for k = 1 : length(comb)
    
    ind = comb(k, :);
    
    if ind == [104,101,34,73,66,75];
        b =0;
        
    end;
    
    if ind == [101,34,73,66,75,105];
        b =0;
        
    end;
    
     vectorU = u(:,ind);       
     vectorX = x(:,ind);
    
     M = [
            vectorX(:,1)' 1 0 0 0 0 -vectorU(1,1)*[vectorX(:,1)' 1];
            0 0 0 0 vectorX(:,1)' 1 -vectorU(2,1)*[vectorX(:,1)' 1];
            
            vectorX(:,2)' 1 0 0 0 0 -vectorU(1,2)*[vectorX(:,2)' 1];
            0 0 0 0 vectorX(:,2)' 1 -vectorU(2,2)*[vectorX(:,2)' 1];
            
            vectorX(:,3)' 1 0 0 0 0 -vectorU(1,3)*[vectorX(:,3)' 1];
            0 0 0 0 vectorX(:,3)' 1 -vectorU(2,3)*[vectorX(:,3)' 1];
            
            vectorX(:,4)' 1 0 0 0 0 -vectorU(1,4)*[vectorX(:,4)' 1];
            0 0 0 0 vectorX(:,4)' 1 -vectorU(2,4)*[vectorX(:,4)' 1];
            
            vectorX(:,5)' 1 0 0 0 0 -vectorU(1,5)*[vectorX(:,5)' 1];
            0 0 0 0 vectorX(:,5)' 1 -vectorU(2,5)*[vectorX(:,5)' 1];
            
            vectorX(:,6)' 1 0 0 0 0 -vectorU(1,6)*[vectorX(:,6)' 1];
            0 0 0 0 vectorX(:,6)' 1 -vectorU(2,6)*[vectorX(:,6)' 1]
        ];
        
        
        for i = 1 : 12
            Mi = M;
            Mi(i, :) = 0;
            
            % 1x12 matrix             
            qi = null(Mi);
            
            % 3x4
            qi = [qi(1:4)'; qi(5:8)'; qi(9:12)'];
                             
            errorMax = 0;
            % go thru all x vectors
            for j = 1:size(x,2)
                xj = [x(:,j); 1];
                uj = qi*xj;  
                uj = uj/uj(3);
                ej = norm(uj - [u(:,j); 1]);
                errorMax = max(ej, errorMax); 
            end;
            
            index = (k - 1)* 12 + i;
            Q_all(:, :, index) = qi;
            err_max = [err_max errorMax];
            if err_max == 1.22819528086880
                 b =0;
            end;
             if ind == [101,34,73,66,75,105];
                b =0;

            end;
            helpPointsSel(:, index) = ind;
        end;  
        
end;

[~, minInd] = min(err_max);
Q = Q_all(:, :,minInd);
points_sel = helpPointsSel(:, minInd);

% 3x4 * 4x6 = 3x6
tmp = [];
for j = 1 : 109
    tmp = [tmp 1];     
end;
ui = Q*[x; tmp];
for j = 1 : 109
    ui(:, j) = ui(:, j)/ui(3, j);
end;
% 2x109
ui = ui([1:2],:); 
err_points = ui;




