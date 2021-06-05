% clear
clc, clear, close all
I = imread('..\exp\img\cameraman.bmp');

S = qtdecomp(I, .27);

s2 = full(S);
[a, b] = size(s2);

for i = 1:a

    for j = 1:b

        if s2(i, j) >= 4
            s2(i, j) = 0;
        elseif s2(i, j) > 1

            for k = 1:s2(i, j)

                for l = 1:s2(i, j)
                    s2(i + k, j + l) = 1;
                end

            end

        end

    end

end

for i = 1:a - 1

    for j = 1:b - 1

        if s2(i, j) > 0 && s2(i, j + 1) == 0 && s2(i + 1, j) == 0 && s2(i + 1, j + 1) > 0
            s2(i, j + 1) = 1;
            s2(i + 1, j) = 1;
        end

    end

end

blocks = repmat(uint8(0), size(S));

for dim = [512 256 128 64 32 16 8 4 2 1]
    numblocks = length(find(S == dim));

    if (numblocks > 0)
        values = repmat(uint8(1), [dim dim numblocks]);
        values(2:dim, 2:dim, :) = 0;
        blocks = qtsetblk(blocks, S, dim, values);
    end

end

blocks(end, 1:end) = 1;
blocks(1:end, end) = 1;
figure
subplot(2, 1, 1);
imshow(I)
subplot(2, 1, 2)
imshow(s2)
