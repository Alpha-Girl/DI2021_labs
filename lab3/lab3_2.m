% clear
clc,clear,close all

i1=imread('..\exp\img\lena.bmp');
f=figure()
i2=imnoise(i1, 'gaussian'); %高斯
i3=imnoise(i1, 'salt & pepper',0.03);  %椒盐
i4 = add_RVIN(i1, 0.03); %随机
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

fil=fspecial('average',3);
i2_new=imfilter(i2, fil);
i3_new=imfilter(i3, fil);
i4_new=imfilter(i4, fil);
i5_new=imfilter(i5, fil);
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
i2_s=SuperNeighborhoodAverageFiltering(i1,i2_new,T);
i3_s=SuperNeighborhoodAverageFiltering(i1,i3_new,T);
i4_s=SuperNeighborhoodAverageFiltering(i1,i4_new,T);
i5_s=SuperNeighborhoodAverageFiltering(i1,i5_new,T);
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
function [ result ] = SuperNeighborhoodAverageFiltering( original,fixed,T)

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
function RVIN_img = add_RVIN(init_img, nl)

    [M, N, Z] = size(init_img);

    if Z > 1
        init_img = rgb2gray(init_img);
    end

    noise_img = imnoise(uint8(init_img), 'salt & pepper', nl);
    noise_map = zeros(M, N);
    noise_map = init_img - noise_img ~= 0;
    total_noise = sum(noise_map(:));
    RVIN_img = init_img;
    noise_num = 0;

    for i = 1:M

        for j = 1:N

            if init_img(i, j) ~= noise_img(i, j)
                noise_num = noise_num + 1;

                for k = 1:255
                    rand_num = round(rand(1, 1) * 255);

                    if rand_num ~= init_img(i, j)
                        RVIN_img(i, j) = rand_num;
                        break;
                    end

                end

            end

        end

    end

    noise_density = noise_num / (M * N); %计算噪声密度
end