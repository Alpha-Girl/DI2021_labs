% clear
clc,clear,close all

rgb1 = imread('.\exp\实验图像\alphabet1.jpg')
f= figure()
se = translate(strlen(1),[100,100])
rbg2 = imdilate(rbg1, se)
subplot(1, 2, 1)
imshow(rgb1)
title('origin')
subplot(1,2,2)
imshow(rbg2)
title('translation')