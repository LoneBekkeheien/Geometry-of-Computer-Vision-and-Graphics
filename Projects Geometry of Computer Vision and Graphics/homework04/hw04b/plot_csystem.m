function plot_csystem ( base, b, color, name )
hold on


nameMap = ['_x'; '_y'; '_z'];
s = size(base,2);

if s == 2
    
    plot3( [b(1); base(1,1)+b(1)] ,  [b(2); base(2,1)+b(2)],  [b(3); base(3,1)+b(3)], color, 'linewidth', 1 );
    plot3( [b(1); base(1,2)+b(1)] ,  [b(2); base(2,2)+b(2)],  [b(3); base(3,2)+b(3)], color, 'linewidth', 1 );
    
    text( base(1,1)+b(1), base(2,1)+b(2), base(3,1)+b(3), strcat(name, nameMap(1, :)));
    text( base(1,2)+b(1), base(2,2)+b(2), base(3,2)+b(3), strcat(name, nameMap(2, :)));
%     plot3( [b(1); base(3,1)+b(1)] ,  [b(2); base(3,2)+b(2)], [0; 0], color, 'linewidth', 1 );    
end;

if s == 3
    plot3( [b(1); base(1,1)+b(1)] ,  [b(2); base(2,1)+b(2)],  [b(3); base(3,1)+b(3)], color, 'linewidth', 1 );
    plot3( [b(1); base(1,2)+b(1)] ,  [b(2); base(2,2)+b(2)],  [b(3); base(3,2)+b(3)], color, 'linewidth', 1 );
    plot3( [b(1); base(1,3)+b(1)] ,  [b(2); base(2,3)+b(2)],  [b(3); base(3,3)+b(3)], color, 'linewidth', 1 );
    
    text( base(1,1)+b(1), base(2,1)+b(2), base(3,1)+b(3), strcat(name, nameMap(1, :)));
    text( base(1,2)+b(1), base(2,2)+b(2), base(3,2)+b(3), strcat(name, nameMap(2, :)));
    text( base(1,3)+b(1), base(2,3)+b(2), base(3,3)+b(3), strcat(name, nameMap(3, :)));
end;

   

hold off
