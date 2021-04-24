% clear
clc,clear,close all


rgb1 = imread('..\exp\img\alphabet1.jpg')
transformed = LinearTransformFunc(rgb1, 3, -44);

figure
imshow(transformed)

function [ new ] = LinearTransformFunc( original, k, d )
    new = original * k + d;
end