%% clear
clc,clear,close all

i1=imread('..\exp\img\Rect1.bmp');
i1_1=imread('..\exp\img\Rect2.bmp');
i2=fft2(i1);
i3=fftshift(i2);
i4=abs(i3);
i5=log(i4+1);
i5=uint8(i5);
max1=double(max(i5(:)))/255;
i5=imadjust(i5,[0,max1],[]);
i2_1=fft2(i1_1);
i3_1=fftshift(i2_1);
i4_1=abs(i3_1);
i5_1=log(i4_1+1);
i5_1=uint8(i5_1);
max1_1=double(max(i5_1(:)))/255;
i5_1=imadjust(i5_1,[0,max1_1],[]);
f=figure()
subplot(2, 2, 1)
imshow(i1)
title('rect1')
subplot(2, 2, 2)
imshow(i5)
title('rect1-fft2log')

subplot(2, 2, 3)
imshow(i1_1)
title('rect2')
subplot(2, 2, 4)
imshow(i5_1)
title('rect2-fft2log')