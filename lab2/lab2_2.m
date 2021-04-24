% clear
clc,clear,close all


rgb1 = imread('..\exp\img\alphabet1.jpg');
transformed = StretchFunc(rgb1, 30,10,200,250);

figure
imshow(transformed)

function [ new ] = StretchFunc(original, x1, y1, x2, y2 )
    new = original;

    w = size(new, 1);
    h = size(new, 2);

    k1 = y1 / x1;

    dk1 = (y2 - y1) / (x2 - x1);
    dk2 = (255 - y2) / (255 - x2);

    for i = 1 : w
        for j = 1 : h
            x = new(i, j);
            if x < x1
                new(i, j) = k1 * x;
            elseif x < x2
                new(i, j) = dk1 * (x - x1) + y1;
            else
                new(i, j) = dk2 * (x - x2) + y2;
            end
        end
    end
end