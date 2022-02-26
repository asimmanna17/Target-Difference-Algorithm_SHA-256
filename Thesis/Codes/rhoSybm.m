function f = rhoSybm(state,lanesize)
Rho = [0 1 190 28 91; 36 300 6 55 276;3 10 171 153 231;105 45 15 21 136; 210 66 253 120 78];
r = mod(Rho,lanesize);
for i = 1:5
    for j = 1:5
    state(i,j,:) = circshift(state(i,j,:), -r(i,j),3);
    end
end
f = state;
end
