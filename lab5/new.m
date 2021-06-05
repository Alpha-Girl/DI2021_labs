%% 使用区域分离和合并的图像分割
clc
clear all;
close all;
f = imread('..\exp\img\cameraman.bmp');
figure
subplot(2, 1, 1);
imshow(f);
title('原始图像');

g = uint8(mat2gray(splitmerge(f, 2, @predicate)) * 255); %32代表分割中允许最小的块，predicate函数返回1，说明需要再分裂，返回0说明不需要继续分裂
subplot(2, 1, 2);
imshow(g);
title('分割图像');
se = ones(8, 8);
% gdilate=imdilate(g,se);%膨胀是为了填充空洞
%  subplot(2,2,3);imshow(gdilate);
% title('膨胀后的图')
% gerode=imerode(gdilate,se);%腐蚀是为了缩回原来大小
%  subplot(2,2,4);imshow(gerode);
%  title('腐蚀后的图')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function g = splitmerge(f, mindim, fun) %f是待分割的原图，mindim是定义分解中所允许的最小的块，必须是2的正整数次幂
    Q = 2^nextpow2(max(size(f)));
    [M, N] = size(f);
    f = padarray(f, [Q - M, Q - N], 'post'); %：填充图像或填充数组。f是输入图像，输出是填充后的图像，先将图像填充到2的幂次以使后面的分解可行
    %然后是填充的行数和列数，post：表示在每一维的最后一个元素后填充,B = padarray(A,padsize,padval,direction)
    %不含padval就用0填充,Q代表填充后图像的大小。
    S = qtdecomp(f, @split_test, mindim, fun); %S传给split_test，qtdecomp divides a square image into four
    % equal-sized square blocks, and then tests each block to see if it
    % meets some criterion of homogeneity. If a block meets the criterion,
    % it is not divided any further. If it does not meet the criterion,
    % it is subdivided again into four blocks, and the test criterion is
    % applied to those blocks. This process is repeated iteratively until
    % each block meets the criterion. The result can have blocks of several
    % different sizes.S是包含四叉树结构的稀疏矩阵，存储的值是块的大小及坐标，以稀疏矩阵形式存储
    Lmax = full(max(S(:))); %将以稀疏矩阵存储形式存储的矩阵变换成以普通矩阵（full matrix）形式存储，full，sparse只是存储形式的不同
    g = zeros(size(f));
    MARKER = zeros(size(f));

    for k = 1:Lmax
        [vals, r, c] = qtgetblk(f, S, k); %vals是一个数组，包含f的四叉树分解中大小为k*k的块的值，是一个k*k*个数的矩阵，
        %个数是指S中有多少个这样大小的块，f是被四叉树分的原图像，r，c是对应的左上角块的坐标如2*2块，代表的是左上角开始块的坐标

        if ~isempty(vals)

            for I = 1:length(r)
                xlow = r(I);
                ylow = c(I);
                xhigh = xlow + k - 1;
                yhigh = ylow + k - 1;
                region = f(xlow:xhigh, ylow:yhigh); %找到对应的区域
                flag = feval(fun, region); %evaluates the function handle, fhandle,using arguments x1 through xn.执行函数fun，region是参数

                if flag %如果返回的是1，则进行标记
                    g(xlow:xhigh, ylow:yhigh) = 1; %然后将对应的区域置1
                    MARKER(xlow, ylow) = 1; %MARKER矩阵对应的左上角坐标置1
                end

            end

        end

    end

    g = bwlabel(imreconstruct(MARKER, g)); %imreconstruct默认2D图像8连通，这个函数就是起合的作用
    g = g(1:M, 1:N); %返回原图像的大小
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

function v = split_test(B, mindim, fun)
    K = size(B, 3); %B就是qtdecomp函数传过来的，代表当前size(B,3)返回的是B的层数，就是B是几维的，这里实际上就是有几个B这样大小的图像块
    %这句代码的意思是从qtdecomp函数传过来的B，是当前分解成的K块的m*m的图像块，K表示有多少个这样大小的图像块
    v(1:K) = false;

    for I = 1:K
        quadregion = B(:, :, I);

        if size(quadregion, 1) <= mindim %如果分的块的大小小于mindim就直接结束
            v(I) = false;
            continue
        end

        flag = feval(fun, quadregion); %quadregion是fun函数的参数

        if flag %如果flag是1，代表需要再分
            v(I) = true; %这里就相当于split_test是起一个调用predicate的作用，返回的就是ppredicate的值
        end

    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function flag = predicate(region)
    sd = std2(region);
    m = mean2(region);

    flag = (sd > 20) & (m > 26) & (m < 255);
    %predicate用于两个目的，在split_test中被调用时，判断是否该被分，如果满足这个条件就返回1，需要再分，否则就返回0，不能再被分
    %在开始合并时调用它，用于判断是否该进行合并标记，返回1，表示通过测试，四叉区域都用1填充，返回0代表没有通过测试，用0填充
    %所以区域分裂与合并的分割方法中，predicate函数是用户自定义的，改动性最大，最关键，关乎分割效果的好坏，用于两个目的时可以分别定义不同的
    %函数准则，以达到最好的效果。
end
