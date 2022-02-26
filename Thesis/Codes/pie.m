function f = pie(state, laneSize, inverse)
    f = zeros(5,5,laneSize);
    for slice = 1 : laneSize 
        f(:,:,slice) = piSlice(state(:,:,slice));
    end

       function f = piSlice(s)
           
           if(inverse == 0)      
               f(1,:) = [s(1,1) s(2,2) s(3,3) s(4,4) s(5,5)];
               f(2,:) = [s(1,4) s(2,5) s(3,1) s(4,2) s(5,3)];
               f(3,:) = [s(1,2) s(2,3) s(3,4) s(4,5) s(5,1)];
               f(4,:) = [s(1,5) s(2,1) s(3,2) s(4,3) s(5,4)];
               f(5,:) = [s(1,3) s(2,4) s(3,5) s(4,1) s(5,2)];
           elseif(inverse == 1)
               f(1,:) = [s(1,1) s(3,1) s(5,1) s(2,1) s(4,1)];
               f(2,:) = [s(4,2) s(1,2) s(3,2) s(5,2) s(2,2)];
               f(3,:) = [s(2,3) s(4,3) s(1,3) s(3,3) s(5,3)];
               f(4,:) = [s(5,4) s(2,4) s(4,4) s(1,4) s(3,4)];
               f(5,:) = [s(3,5) s(5,5) s(2,5) s(4,5) s(1,5)];
           end

           %Test later for automated permuation matric generation
           %m = [0 1; 2 3];
           %for x = 1 : 5
           %    for y = 1 : 5
           %         co_or = [y-3; 3-x];
           %         %z = m*co_or
           %        % piOut(3-z(2), z(1)+3) = slice(x, y);
           %    end
           %end 
       end
end 