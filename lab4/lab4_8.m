clear all;
clc;

%% 读取原图像
Original_image = imread('..\exp\img\pout.bmp');
[len, wid] = size(Original_image);
Original_image = im2double(Original_image);
g = fft2(Original_image); %二维傅立叶变换
g = fftshift(g); %频移

%% 设计巴特沃斯滤波器
n1 = 2; %巴特沃斯滤波器阶数为2
D0 = 0.05 * len; %截止频率5 %的图像宽度
[M, N] = size(g);
m = fix(M / 2);
n = fix(N / 2);

for i = 1:M

    for j = 1:N
        D = sqrt((i - m)^2 + (j - n)^2);
        h1 = 1 / (1 + (D0 / D)^(2 * n1)); %计算高通滤波器传递函数
        h2 = 0.5 + 2 * h1; %设计high-frequency emphasis其中a=0.5,b=2.0
        s1(i, j) = h2 * g(i, j); %用设计的滤波器处理原图像
    end

end

%% 傅里叶反变换后
filter_image1 = im2uint8(real(ifft2(ifftshift(s1)))); %傅里叶反变换
subplot(2, 2, 4), imshow(filter_image1), title('只高频增强滤波');
res = GrayScale(filter_image1);
rgb1 = Balance(filter_image1, res);
%% 变换前后图像显示
subplot(2, 2, 1), imshow(Original_image), title('原图');
subplot(2, 2, 2), imshow(rgb1), title('先高频增强滤波，再直方图均衡化');
Original_image = imread('..\exp\img\pout.bmp');
res1 = GrayScale(Original_image);
Original_image = Balance(Original_image, res1);
[len, wid] = size(Original_image);
Original_image = im2double(Original_image);
g = fft2(Original_image); %二维傅立叶变换
g = fftshift(g); %频移

%% 设计巴特沃斯滤波器
n1 = 2; %巴特沃斯滤波器阶数为2
D0 = 0.05 * len; %截止频率5 %的图像宽度
[M, N] = size(g);
m = fix(M / 2);
n = fix(N / 2);

for i = 1:M

    for j = 1:N
        D = sqrt((i - m)^2 + (j - n)^2);
        h1 = 1 / (1 + (D0 / D)^(2 * n1)); %计算高通滤波器传递函数
        h2 = 0.5 + 2 * h1; %设计high-frequency emphasis其中a=0.5,b=2.0
        s1(i, j) = h1 * g(i, j); %用设计的滤波器处理原图像
    end

end

%% 傅里叶反变换后
filter_image1 = im2uint8(real(ifft2(ifftshift(s1)))); %傅里叶反变换
subplot(2, 2, 3), imshow(filter_image1), title('先直方图均衡化，再高频增强滤波');

function [res] = GrayScale(old)
    [w, h] = size(old);
    res = zeros(1, 256);

    for i = 1:w

        for j = 1:h
            g = old(i, j) + 1;
            res(g) = res(g) + 1;
        end

    end

end

function [new] = Balance(old, vec)
    s = sum(vec);
    pr = vec / s;
    len = length(vec);

    for i = 2:len
        pr(i) = pr(i) + pr(i - 1);
    end

    sk = uint8(255 * pr + 0.5);
    [w, h] = size(old);
    new = old;

    for i = 1:w

        for j = 1:h
            new(i, j) = sk(old(i, j) + 1);
        end

    end

end
