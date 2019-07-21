function [] = plot_border(H, tall)
ImgW=2400;
ImgH=1800;

cr1 = [0; 0; 1];
cr3 = [ImgW/2; ImgH/2; 1];
cr4 = [0; ImgH/2; 1];
cr2 = [ImgW/2; 0; 1];


hold on;
cr2 = H*cr2;
cr1 = H*cr1;
cr4 = H*cr4;
cr3 = H*cr3;
cr1 = cr1(1:2)/cr1(3);
cr3 = cr3(1:2)/cr3(3);
cr4 = cr4(1:2)/cr4(3);
cr2 = cr2(1:2)/cr2(3);




text( cr1(1), cr1(2), tall, 'color', 'red', 'FontSize', 16  );
plot([cr1(1) cr2(1)],[cr1(2) cr2(2)], '-', 'linewidth', 0.75, 'color', 'red');
plot([cr2(1) cr3(1)],[cr2(2) cr3(2)], '-', 'linewidth', 0.75, 'color', 'red');
plot([cr3(1) cr4(1)],[cr3(2) cr4(2)], '-', 'linewidth', 0.75, 'color', 'red');
plot([cr4(1) cr1(1)],[cr4(2) cr1(2)], '-', 'linewidth', 0.75, 'color', 'red');

hold off;

end