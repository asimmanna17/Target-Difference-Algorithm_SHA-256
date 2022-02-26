function f = checkAffineSS (inp)

    dimension = size(inp, 2);

    indexs = nchoosek(1:dimension, 4);

    combinations = nchoosek(dimension, 4);
    
    x = sym('x', [1 5]); %to return the equations

    candInd = 1;
    for i = 1:combinations
        ind = indexs(i,:);
        candidate = inp(ind);
        
        binCand = dec2bin(candidate,5) - '0';
        
        binCand = binCand';

        R1=1;
        for I=1:size(binCand,1)
            R2=rank(binCand(1:I,:));
            if R2~=R1
                disp(I);  
                break;
            end
            R1=R2+1;
        end

        dim = 5 - I;
        
        if(dim == 2)
            f{candInd} = candidate;
            candInd = candInd + 1;
        end

             
    end
end