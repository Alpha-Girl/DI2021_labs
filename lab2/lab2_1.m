% clear
clc, clear, close all

rgb1 = imread('..\exp\img\alphabet1.jpg');
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
            tmp = original(i, j) * k + d;

            if tmp > 255
                tmp = 255;
            elseif tmp < 0
                tmp = 0;
            end

            new(i, j) = tmp;
        end

    end

end
