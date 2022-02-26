function f = rho(state, laneSize, inverse)
    
    %Rho Offsets for laneSize = 64
    rotMat(1,1) =  0;
    rotMat(2,1) =  1;
    rotMat(3,1) = 62;
    rotMat(4,1) = 28;
    rotMat(5,1) = 27;
    rotMat(1,2) = 36;
    rotMat(2,2) = 44;
    rotMat(3,2) =  6;
    rotMat(4,2) = 55;
    rotMat(5,2) = 20;
    rotMat(1,3) =  3;
    rotMat(2,3) = 10;
    rotMat(3,3) = 43;
    rotMat(4,3) = 25;
    rotMat(5,3) = 39;
    rotMat(1,4) = 41;
    rotMat(2,4) = 45;
    rotMat(3,4) = 15;
    rotMat(4,4) = 21;
    rotMat(5,4) =  8;
    rotMat(1,5) = 18;
    rotMat(2,5) =  2;
    rotMat(3,5) = 61;
    rotMat(4,5) = 56;
    rotMat(5,5) = 14;
    
    %Inverse Rho
    if(inverse == 1)
        rotMat = mod(64 - rotMat, 64);
    end

    for i = 1 : 5
        xzPlane = state(i,:,:);
        xzPlane = reshape(xzPlane, 5, laneSize);
        for j = 1 : 5
            lane = xzPlane(j,:);
            lane = circshift(lane', -1 * rotMat(j,i))';
            xzPlane(j,:) = lane;
        end
        xzPlane = reshape(xzPlane, 1, 5, laneSize);
        state(i,:,:) = xzPlane; 
    end
    
    f = state;
end
