% clear
clc,clear,close all

fixed = imread('..\exp\img\alphabet1.jpg');
moving = imread('..\exp\img\alphabet2.jpg');
f=figure()
subplot(2,2,1)
imshow(fixed)
title('origin')
subplot(2,2,2)
imshow(moving)
title('todo')
[selectedMovingPoints,selectedFixedPoints]=cpselect(moving,fixed,'Wait',true);
tform = fitgeotrans(selectedMovingPoints,selectedFixedPoints,'projective')
after_tf = imwarp(moving,tform,'OutputView',imref2d(size(fixed)));
subplot(2,2,[3,4])
imshow(after_tf)
title('after-tf')