function f = thetaTest(state, laneSize)
        
    for i = 1 : laneSize
        p(i,:) = sum(state(:,:,i)); %column parity
    end

    %[x-1][.][z] xor [x+1][.][z-1]
    t(:,1) = p(:,5) + circshift(p(:,2),-1);
    t(:,2) = p(:,1) + circshift(p(:,3),-1);
    t(:,3) = p(:,2) + circshift(p(:,4),-1);
    t(:,4) = p(:,3) + circshift(p(:,5),-1);
    t(:,5) = p(:,4) + circshift(p(:,1),-1);

    %xor with [.]
    for i = 1 : laneSize
        slice = state(:,:,i);
            for j = 1 : 5
                slice(j,:) = slice(j,:) + t(i,:);
            end
        f(:,:,i) = slice;
    end

end





  