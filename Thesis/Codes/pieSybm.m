function f = pieSybm(state,lanesize)

    for slice = 1 : lanesize 
        f(:,:,slice) = piSlice(state(:,:,slice));
     end

    function f = piSlice(s)
    f(1,:) = [s(1,1) s(2,2) s(3,3) s(4,4) s(5,5)];
    f(2,:) = [s(1,4) s(2,5) s(3,1) s(4,2) s(5,3)];
    f(3,:) = [s(1,2) s(2,3) s(3,4) s(4,5) s(5,1)];
    f(4,:) = [s(1,5) s(2,1) s(3,2) s(4,3) s(5,4)];
    f(5,:) = [s(1,3) s(2,4) s(3,5) s(4,1) s(5,2)];          
    end 

end