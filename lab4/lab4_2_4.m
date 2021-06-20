clear all;
clc;
close
I = imread('..\exp\img\pout.bmp');
figure;
subplot(2, 2, 1);
imshow(I);
title('pout.bmpԭͼ');
% �任ƽ��
s = fftshift(fft2(I));
[a, b] = size(s);

for i = 1:a

    for j = 1:b

        s1(i, j) = abs(s(i, j));
        s2(i, j) = angle(s(i, j));
        s3(i, j) = conj(s(i, j));
    end

end

% ����
s1 = uint8(real(ifft2(ifftshift(s1))));
% ��λ
s2 = uint8(mat2gray(abs(ifft2(ifftshift(s2)))) * 255);
% ����
s3 = uint8(real(ifft2(ifftshift(s3))));
subplot(2, 2, 2);
imshow(s1);
title('����');
subplot(2, 2, 3);
imshow(s2);
title('��λ');
subplot(2, 2, 4);
imshow(s3);
title('����');
