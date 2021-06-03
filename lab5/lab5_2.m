% clear
clc, clear, close all
i1 = imread('..\exp\img\lena.bmp');
figure;
subplot(2, 1, 1);
imshow(i1);
T = graythresh(i1);
i2 = imbinarize(i1, T);

subplot(2, 1, 2);
imshow(i2);
