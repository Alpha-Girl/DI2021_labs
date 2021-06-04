clear all;
clc;
close
I = imread('..\exp\img\Girl.bmp');
i2 = imnoise(I, 'gaussian'); %高斯
i3 = imnoise(I, 'salt & pepper', 0.03); %椒盐
figure
subplot(4, 2, 1);
imshow(i3);
title('椒盐');
s = fftshift(fft2(i3));
[a, b] = size(s);
a0 = round(a / 2);
b0 = round(b / 2);
d = 30;

for i = 1:a

    for j = 1:b
        distanc = sqrt((i - a0)^2 + (j - b0)^2);

        if distanc <= d
            h = 1;
        else
            h = 0;
        end

        s1(i, j) = h * s(i, j);
        s2(i, j) = 1 / (1 + (distanc / d)^2) * s(i, j);
        s3(i, j) = exp(-((distanc)^2) / (2 * (d^2))) * s(i, j);
    end

end

s1 = uint8(real(ifft2(ifftshift(s1))));
s2 = uint8(real(ifft2(ifftshift(s2))));
s3 = uint8(real(ifft2(ifftshift(s3))));
subplot(4, 2, 2);
imshow(s1);
title('理想低通滤波');
subplot(4, 2, 3);
imshow(s2);
title('巴特沃斯低通滤波');
subplot(4, 2, 4);
imshow(s3);
title('高斯低通滤波');

subplot(4, 2, 5);
imshow(i2);
title('高斯');
t = fftshift(fft2(i2));
[a, b] = size(t);
a0 = round(a / 2);
b0 = round(b / 2);
d = 30;

for i = 1:a

    for j = 1:b
        distanc = sqrt((i - a0)^2 + (j - b0)^2);

        if distanc <= d
            h = 1;
        else
            h = 0;
        end

        t1(i, j) = h * t(i, j);
        t2(i, j) = 1 / (1 + (distanc / d)^2) * t(i, j);
        t3(i, j) = exp(-((distanc)^2) / (2 * (d^2))) * t(i, j);
    end

end

t1 = uint8(real(ifft2(ifftshift(t1))));
t2 = uint8(real(ifft2(ifftshift(t2))));
t3 = uint8(real(ifft2(ifftshift(t3))));
subplot(4, 2, 6);
imshow(t1);
title('理想低通滤波');
subplot(4, 2, 7);
imshow(t2);
title('巴特沃斯低通滤波');
subplot(4, 2, 8);
imshow(t3);
title('高斯低通滤波');
