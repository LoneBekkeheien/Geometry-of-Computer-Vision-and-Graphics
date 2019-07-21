function plot_csystem(Base, b, color, name,sf)
%    % if(Base==Alpha || Base==Betha)
%    %     Base(:,1)=Base(:,1)*1100;
%    %      Base(:,2)=Base(:,2)*850;
%         
%         
%    % end    
%     
%     q=quiver3(b, Base(:,1), Base(:,2), Base(:,3),sf);
%     text(Base(:,1), Base(:,2), Base(:,3), [ name ], 'color', color );
%     c = q.Color;
%     q.Color = color;
%     %legend(name);
%    % Use as quiver(X,Y,U,V,0) where X,Y is the origin and U,V the vector. The scaling argument 0 ensures the arrow is of the proper length.
end