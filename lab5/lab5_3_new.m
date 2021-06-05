clc,clear,close all

rgb = imread('..\exp\img\cameraman.bmp');

k = 100;
i1 = split(rgb, k);

figure
subplot 121
imshow(rgb)
subplot 122
imshow(i1)

function [new] = split(old, k)
    [m, n] = size(old);
    new = old;
    if m == 1 || n == 1
        return
    end
    c1 = sum(old(:)) / (m * n);
    c2 = sum(sum((old - c1).^2)) / (m * n);
    if c2 > k
        mm = fix(m / 2);
        mn = fix(n / 2);
        new = [
            split(old(1 : mm - 1, 1 : mn - 1), k) 255 * ones(mm - 1, 1) split(old(1 : mm - 1, mn + 1 : n), k)
            255 * ones(1, n)
            split(old(mm + 1 : m, 1 : mn - 1), k) 255 * ones(m - mm, 1) split(old(mm + 1 : m, mn + 1 : n), k)
        ];
    end
end