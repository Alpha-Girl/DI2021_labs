%% clear
clc, clear, close all
window1 = [0, 1, 0;
        1, -4, 1;
        0, 1, 0];
window2 = [1, 1, 1;
        1, -8, 1;
        1, 1, 1];

i1 = imread('..\exp\img\blood.bmp');
i2 = edge(i1, 'Roberts'); % Roberts
i3 = edge(i1, 'Sobel'); % Sobel
i4 = edge(i1, 'Prewitt'); % Prewitt
% laplace
c = conv2(i1, window1, 'same');
i5 = uint8(uni(c));
c = conv2(i1, window2, 'same');
i6 = uint8(uni(c));
% Canny
i7 = edge(i1, 'Canny');
f = figure();
subplot(4, 2, [1, 2]);
imshow(i1);
title('original');
subplot(4, 2, 3);
imshow(i2);
title('Roberts');
subplot(4, 2, 4);
imshow(i3);
title('Sobel');
subplot(4, 2, 5);
imshow(i4);
title('Prewitt');
subplot(4, 2, 6);
imshow(i5);
title('log1');
subplot(4, 2, 7);
imshow(i6);
title('log2');
subplot(4, 2, 8);
imshow(i7);
title('Canny');

function result = uni(img)
    % 尺度变换
    result = img;
    [m, n] = size(img);
    MIN = 10000;
    MAX = -10000;

    for i = 1:m

        for j = 1:n

            if img(i, j) > MAX
                MAX = img(i, j);
            end

            if img(i, j) < MIN
                MIN = img(i, j);
            end

        end

    end

    for i = 1:m

        for j = 1:n
            result(i, j) = floor((img(i, j) - MIN) * 255 / (MAX - MIN));
        end

    end

end
