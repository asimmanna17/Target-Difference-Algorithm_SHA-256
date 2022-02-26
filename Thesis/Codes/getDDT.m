function ddt = getDDT()

    keccakSbox    = [0,5,10,11,20,17,22,23,9,12,3,2,13,8,15,14,18,21,24,27,6,1,4,7,26,29,16,19,30,25,28,31];

    ddt = zeros([32 32]);

    for x1 = 1 : 32
        for x2 = 1 : 32
                        
            y1 = keccakSbox(x1);
            y2 = keccakSbox(x2);

            diffX = bitxor(x1 - 1, x2 -1 );
            diffY = bitxor(y1, y2);

%             ddt(changeEndian(diffX) + 1, changeEndian(diffY) + 1) = ddt(changeEndian(diffX) + 1, changeEndian(diffY) + 1) + 1;
            ddt((diffX) + 1, (diffY) + 1) = ddt((diffX) + 1, (diffY) + 1) + 1;


        end
    end
end

function flippedInput = changeEndian(input)
    flippedInput = bin2dec(num2str(fliplr(dec2bin(input,5) - '0')));
end