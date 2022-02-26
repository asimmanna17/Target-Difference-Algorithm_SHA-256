function f = checkAffineSubspace (inp)

    dimension = size(inp, 2);

    indexs = nchoosek(1:dimension, 4);

    combinations = nchoosek(dimension, 4);

    candInd = 1;
    for i = 1:combinations
        ind = indexs(i,:);
        candidate = inp(ind);

        sumCand = sum(dec2bin(candidate,5) - '0');

        if(sum(sumCand == 0 | sumCand == 4) == 3)
            'Affine'
            f(candInd,:) = candidate;
            candInd = candInd + 1;
        end
        

    end
end