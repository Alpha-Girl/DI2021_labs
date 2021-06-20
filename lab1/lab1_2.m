% clear
clc, clear, close all
% 打开图片
rgb1 = imread('..\exp\img\alphabet1.jpg');
f = figure();
% 旋转
rgb2 = imrotate(rgb1, 60, 'nearest'); % 最近邻插值
rgb3 = imrotate(rgb1, 60, 'bilinear'); % 双线性插值
% 显示
subplot(2, 2, [1, 2]);
imshow(rgb1);
title('origin');
subplot(2, 2, 3);
imshow(rgb2);
title('nearest');
subplot(2, 2, 4);
imshow(rgb3);
title('bilinear');
