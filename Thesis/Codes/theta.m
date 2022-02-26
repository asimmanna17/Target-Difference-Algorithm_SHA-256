function f = theta(state, laneSize)
        
    f = zeros(5, 5, laneSize);
    p = zeros(laneSize, 5);
    for i = 1 : laneSize
        p(i,:) = mod(sum(logical(state(:,:,i))),2); %column parity
    end

    %[x-1][.][z] xor [x+1][.][z-1]
    t(:,1) = bitxor(p(:,5), circshift(p(:,2),-1));
    t(:,2) = bitxor(p(:,1), circshift(p(:,3),-1));
    t(:,3) = bitxor(p(:,2), circshift(p(:,4),-1));
    t(:,4) = bitxor(p(:,3), circshift(p(:,5),-1));
    t(:,5) = bitxor(p(:,4), circshift(p(:,1),-1));

    %xor with [.]
    for i = 1 : laneSize
        slice = state(:,:,i);
            for j = 1 : 5
                slice(j,:) = bitxor(slice(j,:), t(i,:));
            end
        f(:,:,i) = slice;
    end

end