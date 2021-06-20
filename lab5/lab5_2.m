% clear
clc, clear, close all
% 打开图片
i1 = imread('..\exp\img\lena.bmp');
figure;
subplot(2, 1, 1);
imshow(i1);
% 找到类间方差最大的阈值T
T = graythresh(i1);
% 分割二值化
i2 = imbinarize(i1, T);

subplot(2, 1, 2);
imshow(i2);
