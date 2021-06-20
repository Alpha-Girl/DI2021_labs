% clear
clc, clear, close all
% 打开图片
original = imread('..\exp\img\lena.bmp');
% 设置上下限
low = 100;
high = 255;
i1 = original;
[counts, bins] = imhist(i1);
% 统计
y = GrayScaleStatistic(i1, low, high);
x = low:1:high;
f = figure();
% 显示
subplot(1, 2, 1)
imshow(original)
title('original')
%subplot(2, 2, 2)
%histogram(i1)
%title('imhist-histogram')
subplot(1, 2, 2)
bar(x, y)
title('imhist-my')
%subplot(2, 2, 4)
%bar(bins,counts)
%title('imhist-imhist')

function [result] = GrayScaleStatistic(original, low, high)

    w = size(original, 1);
    h = size(original, 2);
    result = zeros(1, high - low + 1);
    % 遍历
    for i = 1:w

        for j = 1:h
            g = original(i, j);

            if g >= low && g <= high
                g = g - low + 1;
                result(g) = result(g) + 1;
            end

        end

    end

end
