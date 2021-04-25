%% clear
clc,clear,close all

i1=imread('..\exp\img\lena.bmp');

i2=edge(i1,'Roberts');
i3=edge(i1,'Sobel');
i4=edge(i1,'Prewitt');
i5=edge(i1, 'log');
i6=edge(i1,'Canny');

f=figure()
subplot(3, 2, 1)
imshow(i1)
title('original')
subplot(3,2,2)
imshow(i2)
title('Roberts')
subplot(3, 2, 3)
imshow(i3)
title('Sobel')
subplot(3,2,4)
imshow(i4)
title('Prewitt')
subplot(3,2,5)
imshow(i5)
title('log')
subplot(3,2,6)
imshow(i6)
title('Canny')