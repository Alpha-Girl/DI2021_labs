%% ʹ���������ͺϲ���ͼ��ָ�
clc
clear all;
close all;
f = imread('..\exp\img\cameraman.bmp');
figure
subplot(2, 1, 1);
imshow(f);
title('ԭʼͼ��');

g = uint8(mat2gray(splitmerge(f, 2, @predicate)) * 255); %32����ָ���������С�Ŀ飬predicate��������1��˵����Ҫ�ٷ��ѣ�����0˵������Ҫ��������
subplot(2, 1, 2);
imshow(g);
title('�ָ�ͼ��');
se = ones(8, 8);
% gdilate=imdilate(g,se);%������Ϊ�����ն�
%  subplot(2,2,3);imshow(gdilate);
% title('���ͺ��ͼ')
% gerode=imerode(gdilate,se);%��ʴ��Ϊ������ԭ����С
%  subplot(2,2,4);imshow(gerode);
%  title('��ʴ���ͼ')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function g = splitmerge(f, mindim, fun) %f�Ǵ��ָ��ԭͼ��mindim�Ƕ���ֽ������������С�Ŀ飬������2������������
    Q = 2^nextpow2(max(size(f)));
    [M, N] = size(f);
    f = padarray(f, [Q - M, Q - N], 'post'); %�����ͼ���������顣f������ͼ������������ͼ���Ƚ�ͼ����䵽2���ݴ���ʹ����ķֽ����
    %Ȼ��������������������post����ʾ��ÿһά�����һ��Ԫ�غ����,B = padarray(A,padsize,padval,direction)
    %����padval����0���,Q��������ͼ��Ĵ�С��
    S = qtdecomp(f, @split_test, mindim, fun); %S����split_test��qtdecomp divides a square image into four
    % equal-sized square blocks, and then tests each block to see if it
    % meets some criterion of homogeneity. If a block meets the criterion,
    % it is not divided any further. If it does not meet the criterion,
    % it is subdivided again into four blocks, and the test criterion is
    % applied to those blocks. This process is repeated iteratively until
    % each block meets the criterion. The result can have blocks of several
    % different sizes.S�ǰ����Ĳ����ṹ��ϡ����󣬴洢��ֵ�ǿ�Ĵ�С�����꣬��ϡ�������ʽ�洢
    Lmax = full(max(S(:))); %����ϡ�����洢��ʽ�洢�ľ���任������ͨ����full matrix����ʽ�洢��full��sparseֻ�Ǵ洢��ʽ�Ĳ�ͬ
    g = zeros(size(f));
    MARKER = zeros(size(f));

    for k = 1:Lmax
        [vals, r, c] = qtgetblk(f, S, k); %vals��һ�����飬����f���Ĳ����ֽ��д�СΪk*k�Ŀ��ֵ����һ��k*k*�����ľ���
        %������ָS���ж��ٸ�������С�Ŀ飬f�Ǳ��Ĳ����ֵ�ԭͼ��r��c�Ƕ�Ӧ�����Ͻǿ��������2*2�飬����������Ͻǿ�ʼ�������

        if ~isempty(vals)

            for I = 1:length(r)
                xlow = r(I);
                ylow = c(I);
                xhigh = xlow + k - 1;
                yhigh = ylow + k - 1;
                region = f(xlow:xhigh, ylow:yhigh); %�ҵ���Ӧ������
                flag = feval(fun, region); %evaluates the function handle, fhandle,using arguments x1 through xn.ִ�к���fun��region�ǲ���

                if flag %������ص���1������б��
                    g(xlow:xhigh, ylow:yhigh) = 1; %Ȼ�󽫶�Ӧ��������1
                    MARKER(xlow, ylow) = 1; %MARKER�����Ӧ�����Ͻ�������1
                end

            end

        end

    end

    g = bwlabel(imreconstruct(MARKER, g)); %imreconstructĬ��2Dͼ��8��ͨ���������������ϵ�����
    g = g(1:M, 1:N); %����ԭͼ��Ĵ�С
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
end

function v = split_test(B, mindim, fun)
    K = size(B, 3); %B����qtdecomp�����������ģ�����ǰsize(B,3)���ص���B�Ĳ���������B�Ǽ�ά�ģ�����ʵ���Ͼ����м���B������С��ͼ���
    %���������˼�Ǵ�qtdecomp������������B���ǵ�ǰ�ֽ�ɵ�K���m*m��ͼ��飬K��ʾ�ж��ٸ�������С��ͼ���
    v(1:K) = false;

    for I = 1:K
        quadregion = B(:, :, I);

        if size(quadregion, 1) <= mindim %����ֵĿ�Ĵ�СС��mindim��ֱ�ӽ���
            v(I) = false;
            continue
        end

        flag = feval(fun, quadregion); %quadregion��fun�����Ĳ���

        if flag %���flag��1��������Ҫ�ٷ�
            v(I) = true; %������൱��split_test����һ������predicate�����ã����صľ���ppredicate��ֵ
        end

    end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function flag = predicate(region)
    sd = std2(region);
    m = mean2(region);

    flag = (sd > 20) & (m > 26) & (m < 255);
    %predicate��������Ŀ�ģ���split_test�б�����ʱ���ж��Ƿ�ñ��֣����������������ͷ���1����Ҫ�ٷ֣�����ͷ���0�������ٱ���
    %�ڿ�ʼ�ϲ�ʱ�������������ж��Ƿ�ý��кϲ���ǣ�����1����ʾͨ�����ԣ��Ĳ�������1��䣬����0����û��ͨ�����ԣ���0���
    %�������������ϲ��ķָ���У�predicate�������û��Զ���ģ��Ķ��������ؼ����غ��ָ�Ч���ĺû�����������Ŀ��ʱ���Էֱ��岻ͬ��
    %����׼���Դﵽ��õ�Ч����
end
