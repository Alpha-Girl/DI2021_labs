% clear
clc, clear, close all
% 打开图片
rgb1 = imread('..\exp\img\alphabet1.jpg');
f = figure();
% 平移
se = translate(strel(1), [100, 100]);
rgb2 = imdilate(rgb1, se);
% 显示
subplot(1, 2, 1);
imshow(rgb1);
title('origin');
subplot(1, 2, 2);
imshow(rgb2);
title('translation');
