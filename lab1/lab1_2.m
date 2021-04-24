% clear
clc,clear,close all

rgb1 = imread('..\exp\img\alphabet1.jpg')
f = figure()
rgb2 = imrotate(rgb1, 60,'nearest')
rgb3 = imrotate(rgb1, 60,'bilinear')
subplot(2,2,[1,2])
imshow(rgb1)
title('origin')
subplot(2,2,3)
imshow(rgb2)
title('nearest')
subplot(2,2,4)
imshow(rgb3)
title('bilinear')