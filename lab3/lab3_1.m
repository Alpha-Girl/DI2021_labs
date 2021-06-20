% clear
clc, clear, close all
% ��ͼƬ
i1 = imread('..\exp\img\lena.bmp');
f = figure();
% ����
i2 = imnoise(i1, 'gaussian'); %��˹
i3 = imnoise(i1, 'salt & pepper', 0.03); %����
i4 = add_RVIN(i1, 0.03); %���
i5 = imnoise(i1, 'poisson'); %����

subplot(5, 2, [1, 2]);
imshow(i1);
title('original');
% �����Ľ��
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
% ��ֵ�˲���
fil = fspecial('average', 3);
i2_new = imfilter(i2, fil);
i3_new = imfilter(i3, fil);
i4_new = imfilter(i4, fil);
i5_new = imfilter(i5, fil);
% �˲���Ľ��
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
    % rgbת�Ҷ�ͼ
    if Z > 1
        init_img = rgb2gray(init_img);
    end

    % ����
    noise_img = imnoise(uint8(init_img), 'salt & pepper', nl);
    noise_map = zeros(M, N);
    noise_map = init_img - noise_img ~= 0;
    total_noise = sum(noise_map(:));
    RVIN_img = init_img;
    noise_num = 0;
    % �ڽ��εĻ����������������
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

    noise_density = noise_num / (M * N); %���������ܶ�
end
