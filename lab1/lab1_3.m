% clear
clc, clear, close all
% 打开图片
rgb1 = imread('..\exp\img\alphabet1.jpg');
[h, w, c] = size(rgb1);

f = figure();
% 缩放
rbg2 = imresize(rgb1, [h / 2, w / 3], 'nearest'); % 最近邻插值
rbg3 = imresize(rgb1, [h / 2, w / 3], 'bilinear'); % 双线性插值
% 显示
subplot(2, 2, [1, 2]);
imshow(rgb1);
title('origin');
subplot(2, 2, 3);
imshow(rbg2);
title('nearest');
subplot(2, 2, 4);
imshow(rbg3);
title('bilinear');
