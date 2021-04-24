% clear
clc,clear,close all
original = imread('..\exp\img\lena.bmp');
y = GrayScaleStatistic(original, low, high);
x = low : 1 : high;
bar(x, y)

function [ result ] = GrayScaleStatistic( original, low, high )

    w = size(original, 1);
    h = size(original, 2);
    result = zeros(1, high - low + 1);

    for i = 1 : w
        for j = 1 : h
            g = original(i, j);
            if g >= low && g <= high
                g = g - low + 1;
                result(g) = result(g) + 1; 
            end
        end
    end

end