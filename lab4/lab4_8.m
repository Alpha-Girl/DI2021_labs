clear all;
clc;

%% ��ȡԭͼ��
Original_image = imread('..\exp\img\pout.bmp');
[len, wid] = size(Original_image);
Original_image = im2double(Original_image);
g = fft2(Original_image); %��ά����Ҷ�任
g = fftshift(g); %Ƶ��

%% ��ư�����˹�˲���
n1 = 2; %������˹�˲�������Ϊ2
D0 = 0.05 * len; %��ֹƵ��5 %��ͼ����
[M, N] = size(g);
m = fix(M / 2);
n = fix(N / 2);

for i = 1:M

    for j = 1:N
        D = sqrt((i - m)^2 + (j - n)^2);
        h1 = 1 / (1 + (D0 / D)^(2 * n1)); %�����ͨ�˲������ݺ���
        h2 = 0.5 + 2 * h1; %���high-frequency emphasis����a=0.5,b=2.0
        s1(i, j) = h2 * g(i, j); %����Ƶ��˲�������ԭͼ��
    end

end

%% ����Ҷ���任��
filter_image1 = im2uint8(real(ifft2(ifftshift(s1)))); %����Ҷ���任
subplot(2, 2, 4), imshow(filter_image1), title('ֻ��Ƶ��ǿ�˲�');
res = GrayScale(filter_image1);
rgb1 = Balance(filter_image1, res);
%% �任ǰ��ͼ����ʾ
subplot(2, 2, 1), imshow(Original_image), title('ԭͼ');
subplot(2, 2, 2), imshow(rgb1), title('�ȸ�Ƶ��ǿ�˲�����ֱ��ͼ���⻯');
Original_image = imread('..\exp\img\pout.bmp');
res1 = GrayScale(Original_image);
Original_image = Balance(Original_image, res1);
[len, wid] = size(Original_image);
Original_image = im2double(Original_image);
g = fft2(Original_image); %��ά����Ҷ�任
g = fftshift(g); %Ƶ��

%% ��ư�����˹�˲���
n1 = 2; %������˹�˲�������Ϊ2
D0 = 0.05 * len; %��ֹƵ��5 %��ͼ����
[M, N] = size(g);
m = fix(M / 2);
n = fix(N / 2);

for i = 1:M

    for j = 1:N
        D = sqrt((i - m)^2 + (j - n)^2);
        h1 = 1 / (1 + (D0 / D)^(2 * n1)); %�����ͨ�˲������ݺ���
        h2 = 0.5 + 2 * h1; %���high-frequency emphasis����a=0.5,b=2.0
        s1(i, j) = h1 * g(i, j); %����Ƶ��˲�������ԭͼ��
    end

end

%% ����Ҷ���任��
filter_image1 = im2uint8(real(ifft2(ifftshift(s1)))); %����Ҷ���任
subplot(2, 2, 3), imshow(filter_image1), title('��ֱ��ͼ���⻯���ٸ�Ƶ��ǿ�˲�');

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
