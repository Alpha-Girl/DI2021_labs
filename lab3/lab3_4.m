% clear
clc, clear, close all
% 打开图片
i1 = imread('..\exp\img\lena.bmp');
f = figure()
i2 = imnoise(i1, 'gaussian'); %高斯
i3 = imnoise(i1, 'salt & pepper', 0.03); %椒盐
i4 = add_RVIN(i1, 0.03); %随机
i5 = imnoise(i1, 'poisson'); %泊松
subplot(5, 2, [1, 2]);
imshow(i1);
title('original');
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
% 中值滤波
i2_new = medfilt2(i2, [3, 3]);
i3_new = medfilt2(i3, [3, 3]);
i4_new = medfilt2(i4, [3, 3]);
i5_new = medfilt2(i5, [3, 3]);
% 超限中值滤波
T = 50;
i2_s = SuperNeighborhoodMedFiltering(i1, i2_new, T);
i3_s = SuperNeighborhoodMedFiltering(i1, i3_new, T);
i4_s = SuperNeighborhoodMedFiltering(i1, i4_new, T);
i5_s = SuperNeighborhoodMedFiltering(i1, i5_new, T);

subplot(5, 2, 4);
imshow(i2_s);
title('gaussian-fixed');
subplot(5, 2, 6);
imshow(i3_s);
title('salt & pepper-fixed');
subplot(5, 2, 8);
imshow(i4_s);
title('speckle-fixed');
subplot(5, 2, 10);
imshow(i5_s);
title('poisson-fixed');

function [result] = SuperNeighborhoodMedFiltering(original, fixed, T)

    w = size(original, 1);
    h = size(original, 2);
    result = original;
    % 判断是否超限
    for i = 1:w

        for j = 1:h
            t1 = original(i, j);
            t2 = fixed(i, j);

            if abs(t1 - t2) > T
                result(i, j) = t2;
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
