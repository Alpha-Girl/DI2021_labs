clc, clear, close all
% 打开图片
rgb = imread('..\exp\img\pout.bmp');
% 直方图
res = GrayScale(rgb);
% 均衡化
rgb1 = Balance(rgb, res);
% 均衡化后的直方图
res1 = GrayScale(rgb1);
% 规定化为高斯分布
rgb2 = Gauss(rgb, res);
% 规定化后的直方图
res2 = GrayScale(rgb2);
% 显示
figure();
subplot(3, 2, 1)
imshow(rgb)
title('origin')
subplot(3, 2, 2)
bar(0:255, res)
title('GrayScale')
subplot(3, 2, 3)
imshow(rgb1)
title('balanced')
subplot(3, 2, 4)
bar(0:255, res1)
title('balanced GrayScale')
subplot(3, 2, 5)
imshow(rgb2)
title('gauss')
subplot(3, 2, 6)
bar(0:255, res2)
title('gauss GrayScale')

function [res] = GrayScale(old)
    [w, h] = size(old);
    res = zeros(1, 256);
    % 遍历统计
    for i = 1:w

        for j = 1:h
            g = old(i, j);
            res(g) = res(g) + 1;
        end

    end

end

function [new] = Balance(old, vec)
    s = sum(vec);
    pr = vec / s;
    len = length(vec);
    % 统计分布
    for i = 2:len
        pr(i) = pr(i) + pr(i - 1);
    end

    sk = uint8(255 * pr + 0.5);
    [w, h] = size(old);
    new = old;
    % 映射
    for i = 1:w

        for j = 1:h
            new(i, j) = sk(old(i, j) + 1);
        end

    end

end

function [new] = Gauss(old, vec)
    len = length(vec);
    x = 1:1:len;
    % 高斯分布
    y = gaussmf(x, [50 (len + 1) / 2]);
    s1 = sum(y);
    pr1 = y / s1;
    s2 = sum(vec);
    pr2 = vec / s2;
    % 统计分布
    for i = 2:len
        pr1(i) = pr1(i) + pr1(i - 1);
        pr2(i) = pr2(i) + pr2(i - 1);
    end

    sk = zeros(1, 256);
    cur = 1;
    % 生成映射
    for i = 1:len

        while cur < len && pr2(i) - pr1(cur) > pr1(cur + 1) - pr2(i)
            cur = cur + 1;
        end

        sk(i) = cur;
    end

    [w, h] = size(old);
    new = old;
    % 映射
    for i = 1:w

        for j = 1:h
            new(i, j) = sk(old(i, j) + 1);
        end

    end

end
