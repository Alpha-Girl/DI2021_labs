% clear
clc,clear,close all

i1=imread('..\exp\img\lena.bmp');
f=figure()
i2=imnoise(i1, 'gaussian') %高斯
i3=imnoise(i1, 'speckle')  %椒盐
i4=imnoise(i1, 'poisson')  %随机
i5=imnoise(i1, 'salt & pepper') %泊松
subplot(5, 2, [1,2])
imshow(i1)
title('original')
subplot(5, 2, 3)
imshow(i2)
title('gaussian')
subplot(5, 2, 5)
imshow(i3)
title('speckle')
subplot(5, 2, 7)
imshow(i4)
title('poisson')
subplot(5, 2, 9)
imshow(i5)
title('salt & pepper')

fil=fspecial('average',3);
i2_new=imfilter(i2, fil);
i3_new=imfilter(i3, fil);
i4_new=imfilter(i4, fil);
i5_new=imfilter(i5, fil);
subplot(5, 2, 4)
imshow(i2_new)
title('gaussian-new')
subplot(5, 2, 6)
imshow(i3_new)
title('speckle-new')
subplot(5, 2, 8)
imshow(i4_new)
title('poisson-new')
subplot(5, 2, 10)
imshow(i5_new)
title('salt & pepper-new')