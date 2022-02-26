function f = chi(state, laneSize, inverse)
        f = zeros(5,5,laneSize);
        for z = 1 : laneSize 
            f(:,:,z) = chiSlice(state(:,:,z));
        end
        
        function f = chiSlice(slice)
            f = zeros(5);
            for y = 1 : 5 
                if(inverse == 0)
                    f(y,:) = chiRow(slice(y,:));
                else
                    f(y,:) = chiRowInv(slice(y,:));
                end
            end
        end

        function f = chiRow(row)
            f = zeros(1,5);
            for x = 1 : 5 
                f(x) = bitxor(row(x), ((~row(mod(x, 5) + 1)) & row(mod(x + 1, 5) + 1)));
            end         
        end
    
        function f = chiRowInv(row)
            
            sbox    = [0,5,10,11,20,17,22,23,9,12,3,2,13,8,15,14,18,21,24,27,6,1,4,7,26,29,16,19,30,25,28,31];
            sboxinv = [0,21,11,10,22,1,20,23,13,8,2,3,9,12,15,14,26,5,16,27,4,17,6,7,18,29,24,19,30,25,28,31];

            index   = bin2dec(num2str(row')');     
            sboxOut = sboxinv(index + 1);
            
            f = str2num(dec2bin(sboxOut,5)')';
        end
    
end 

    