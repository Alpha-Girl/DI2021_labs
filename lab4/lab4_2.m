%% clear
clc,clear,close all
i1=imread('..\exp\img\Rect1.bmp');
f=figure()
subplot(2,2,1)
imshow(i1)
title('original')
i2=fft2(i1);
i3=fftshift(i2);
RR=real(i3);
II=imag(i3);
i4=sqrt(RR.^2+II.^2);%幅度
i5=log(i4+1);
i5=uint8(i5);
max1=double(max(i5(:)))/255;
i5=imadjust(i5,[0,max1],[]);
i6=uint8(ifft2(ifftshift(i4)));
i7=uint8(ifft2(ifftshift((angle(i3)))));
subplot(2,2,2)
imshow(i5)
title('fft2')
subplot(2,2,3)
imshow(i6)
title('ifft2-幅度')

subplot(2,2,4)
imshow(i7)
title('ifft2-相位')