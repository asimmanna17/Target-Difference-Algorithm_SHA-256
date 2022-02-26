function lmat = getLmat(laneSize)
    %laneSize = 2;
    a = sym('a', [5 5 laneSize]);
    b = zeros(5,5,laneSize);

    y = thetaTest(a,laneSize);
    y = rhoSybm(y,laneSize);
    y = pieSybm(y,laneSize);

%     eq = sym ('eq' , [5 5 lanesize]);

%     eq = y == b;

    [A B] = equationsToMatrix(y==b, a);

    lmat = double(A);


end