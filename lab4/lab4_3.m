%% clear
clc,clear,close all
i1=imread('..\exp\img\Rect1.bmp');
f=figure()
subplot(2,2,[1,2])
imshow(i1)
title('original')
i2=fft2(i1);
i3=fftshift(i2);
i4=abs(i3);
i4_theta=
i5=log(i4+1);
i5=uint8(i5);
max1=double(max(i5(:)))/255;
i5=imadjust(i5,[0,max1],[]);
i6=uint8(ifft2(ifftshift(i4)));

subplot(2,2,3)
imshow(i5)
title('fft2')
subplot(2,2,4)
imshow(i6)
title('ifft2')
