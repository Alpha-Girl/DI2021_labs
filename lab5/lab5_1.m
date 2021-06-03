clear;
close all;
clc
%Read image
I = im2double(imread('..\exp\img\flower1.jpg'));
figure, subplot(4, 4, 1), imshow(I);
title('Original Image');
noise = imnoise(zeros(size(I)), 'gaussian', 0, 0.0001);

%Simulate a motion blur
LEN = 30;
THETA = 45;
PSF = fspecial('motion', LEN, THETA);
blurred = imfilter(I, PSF, 'circular');
subplot(4, 4, 2), imshow(blurred);
title('Blurred Image');

%Simulate the noise image
g = I + noise;
subplot(4, 4, 3), imshow(g);
title('noise image');

%Simulate blur and noise
bg = blurred + noise;
subplot(4, 4, 4), imshow(bg)
title('Blur and Noise image')

%Restore the I image
wnr11 = deconvwnr(I, PSF); %�����Ϊ��
subplot(4, 4, 5), imshow(wnr11);
title('Original Image��S/N=0');

wnr12 = deconvwnr(blurred, PSF); %�����Ϊ��
subplot(4, 4, 6), imshow(wnr12);
title('blurred Image��S/N=0');

wnr13 = deconvwnr(g, PSF); %�����Ϊ��
subplot(4, 4, 7), imshow(wnr13);
title('noise Image��S/N=0');

wnr14 = deconvwnr(bg, PSF); %�����Ϊ��
subplot(4, 4, 8), imshow(wnr14);
title('blur and noise Image��S/N=0');

Sn = abs(fft2(noise)).^2;
nA = sum(Sn(:)) / prod(size(noise));
SI = abs(fft2(I)).^2;
IA = sum(SI(:)) / prod(size(I));
R = nA / IA;

wnr21 = deconvwnr(I, PSF, R); %���ű���֪ R
subplot(4, 4, 9), imshow(wnr21);
title('Original Image��N/S=R');

wnr22 = deconvwnr(blurred, PSF, R); %���ű���֪ R
subplot(4, 4, 10), imshow(wnr22);
title('blurred Image��N/S=R');

wnr23 = deconvwnr(g, PSF, R); %���ű���֪ R
subplot(4, 4, 11), imshow(wnr23);
title('noise Image��N/S=R');

wnr24 = deconvwnr(bg, PSF, R); %���ű���֪ R
subplot(4, 4, 12), imshow(wnr24);
title('blur and noise Image��N/S=R');

NCORR = fftshift(real(ifft2(Sn))); %����غ���
ICORR = fftshift(real(ifft2(SI)));

wnr31 = deconvwnr(I, PSF, NCORR, ICORR); %����غ���
subplot(4, 4, 13), imshow(wnr31);
title('Original Image������غ���');

wnr32 = deconvwnr(blurred, PSF, NCORR, ICORR); %����غ���
subplot(4, 4, 14), imshow(wnr32);
title('blurred Image������غ���');

wnr33 = deconvwnr(g, PSF, NCORR, ICORR); %����غ���
subplot(4, 4, 15), imshow(wnr33);
title('noise Image������غ���');

wnr34 = deconvwnr(bg, PSF, NCORR, ICORR); %����غ���
subplot(4, 4, 16), imshow(wnr34);
title('blur and noise Image������غ���');
