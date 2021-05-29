% clear
clc,clear,close all

i1=imread('..\exp\img\lena.bmp');
f=figure()
i2=imnoise(i1, 'gaussian'); %高斯
i3=imnoise(i1, 'salt & pepper',0.03);  %椒盐
i4=imnoise(i1, 'speckle');  %随机
i5=imnoise(i1, 'poisson'); %泊松
subplot(5, 3, [1,3])
imshow(i1)
title('original')
subplot(5, 3, 4)
imshow(i2)
title('gaussian')
subplot(5, 3, 7)
imshow(i3)
title('salt & pepper')
subplot(5, 3, 10)
imshow(i4)
title('speckle')
subplot(5, 3, 13)
imshow(i5)
title('poisson')

i2_new=medfilt2(i2,[3,3]);
i3_new=medfilt2(i3,[3,3]);
i4_new=medfilt2(i4,[3,3]);
i5_new=medfilt2(i5,[3,3]);
subplot(5, 3, 5)
imshow(i2_new)
title('gaussian-new')
subplot(5, 3, 8)
imshow(i3_new)
title('salt & pepper-new')
subplot(5, 3, 11)
imshow(i4_new)
title('speckle-new')
subplot(5, 3, 14)
imshow(i5_new)
title('poisson-new')

T=50;
i2_s=SuperNeighborhoodMedFiltering(i1,i2_new,T);
i3_s=SuperNeighborhoodMedFiltering(i1,i3_new,T);
i4_s=SuperNeighborhoodMedFiltering(i1,i4_new,T);
i5_s=SuperNeighborhoodMedFiltering(i1,i5_new,T);
subplot(5,3, 6)
imshow(i2_s)
title('gaussian-s')
subplot(5, 3, 9)
imshow(i3_s)
title('salt & pepper-s')
subplot(5, 3, 12)
imshow(i4_s)
title('speckle-s')
subplot(5, 3, 15)
imshow(i5_s)
title('poisson-s')
function [ result ] = SuperNeighborhoodMedFiltering( original,fixed,T)

    w = size(original, 1);
    h = size(original, 2);
    result = original;

    for i = 1 : w
        for j = 1 : h
            t1 = original(i, j);
            t2 = fixed(i,j);
            if abs(t1-t2)>T
                result(i,j)=t2;
            end
        end
    end

end