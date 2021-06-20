% clear
clc, clear, close all
% 打开图片
rgb1 = imread('..\exp\img\alphabet1.jpg');
% 灰度变换
transformed = LinearTransformFunc(rgb1, 3, -44);

figure()
subplot(1, 2, 1)
imshow(rgb1);
title('original');
subplot(1, 2, 2);
imshow(transformed);
title('transformed')

function [new] = LinearTransformFunc(original, k, d)
    new = original;
    [a, b] = size(original);

    for i = 1:a

        for j = 1:b
            % 计算变换后的值
            tmp = original(i, j) * k + d;
            % 防止超出灰度范围
            if tmp > 255
                tmp = 255;
            elseif tmp < 0
                tmp = 0;
            end

            % 更新新的灰度值
            new(i, j) = tmp;
        end

    end

end
