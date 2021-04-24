% clear
clc,clear,close all
original = imread('..\exp\img\pout.bmp');
y = GrayScaleStatistic(original, low, high);
x = low : 1 : high;
bar(x, y)
new=Normalize(original,y)
y_new=GrayScaleStatistic(new,low,high)
bar(x,y_new)
f=figure()
subplot(1, 2, 1)
imshow(original)
title('old')
subplot(1, 2, 2)
imshow(new)
title('new')
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
function [ new ] = Normalize( original, v )

    s = sum(v);
    tv = v / s;

    l = length(v);

    for i = 2 : l
        tv(i) = tv(i) + tv(i - 1);
    end

    tk = uint8(255 * tv + 0.5);

    w = size(original, 1);
    h = size(original, 2);

    new = original;

    for i = 1 : w
        for j = 1 : h
            new(i, j) = tk(original(i, j) + 1);
        end
    end

end