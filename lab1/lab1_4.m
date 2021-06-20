% clear
clc, clear, close all
% 打开图片
fixed = imread('..\exp\img\alphabet1.jpg');
moving = imread('..\exp\img\alphabet2.jpg');
f = figure();
subplot(2, 2, 1);
imshow(fixed);
title('origin');
subplot(2, 2, 2);
imshow(moving);
title('todo');
% 选择校正点
[selectedMovingPoints, selectedFixedPoints] = cpselect(moving, fixed, 'Wait', true);
tform = fitgeotrans(selectedMovingPoints, selectedFixedPoints, 'projective');
after_tf = imwarp(moving, tform, 'OutputView', imref2d(size(fixed)));
% 显示结果
subplot(2, 2, [3, 4]);
imshow(after_tf);
title('after-tf');
