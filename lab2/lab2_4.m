% clear
clc,clear,close all
i1= imread('..\exp\img\pout.bmp');

i2=histeq(i1,256)
low=0;
high=255;
y = GrayScaleStatistic(i1, low, high);
x = low : 1 : high;
%bar(x, y)
new=Normalize(i1,y)
y_new=GrayScaleStatistic(new,low,high)
%bar(x,y_new)
f=figure()
subplot(3, 2, 1)
imshow(i1)
title('old')
subplot(3,2,2)
histogram(i1)
title('histogram1')
subplot(3, 2, 3)
imshow(new)
title('new')
subplot(3,2,4)
histogram(new)
title('histogram2')
subplot(3,2,5)
imshow(i2)
title('histeq')
subplot(3,2,6)
histogram(i2)
title('histogram3')
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