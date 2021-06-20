% clear
clc, clear, close all
% 打开图片
i1 = imread('..\exp\img\lena.bmp');
f = figure();
% 加噪
i2 = imnoise(i1, 'gaussian'); %高斯
i3 = imnoise(i1, 'salt & pepper', 0.03); %椒盐
i4 = add_RVIN(i1, 0.03); %随机
i5 = imnoise(i1, 'poisson'); %泊松

subplot(5, 2, [1, 2]);
imshow(i1);
title('original');
% 加噪后的结果
subplot(5, 2, 3);
imshow(i2);
title('gaussian');
subplot(5, 2, 5);
imshow(i3);
title('salt & pepper');
subplot(5, 2, 7);
imshow(i4);
title('speckle');
subplot(5, 2, 9);
imshow(i5);
title('poisson');
% 均值滤波器
fil = fspecial('average', 3);
i2_new = imfilter(i2, fil);
i3_new = imfilter(i3, fil);
i4_new = imfilter(i4, fil);
i5_new = imfilter(i5, fil);
% 滤波后的结果
subplot(5, 2, 4);
imshow(i2_new);
title('gaussian-fixed');
subplot(5, 2, 6);
imshow(i3_new);
title('salt & pepper-fixed');
subplot(5, 2, 8);
imshow(i4_new);
title('speckle-fixed');
subplot(5, 2, 10);
imshow(i5_new);
title('poisson-fixed');

function RVIN_img = add_RVIN(init_img, nl)

    [M, N, Z] = size(init_img);
    % rgb转灰度图
    if Z > 1
        init_img = rgb2gray(init_img);
    end

    % 椒盐
    noise_img = imnoise(uint8(init_img), 'salt & pepper', nl);
    noise_map = zeros(M, N);
    noise_map = init_img - noise_img ~= 0;
    total_noise = sum(noise_map(:));
    RVIN_img = init_img;
    noise_num = 0;
    % 在椒盐的基础上生成随机噪声
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
