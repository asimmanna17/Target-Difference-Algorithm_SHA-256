function [delIn, delOut] = getDelOut(laneSize)

state1 = randi([0 1], 5, 5 , laneSize);
state1(4:5,:,:) = 0;
state1(3,1,:) = mod(state1(1,1,:) + state1(2,1,:), 2);

delIn = zeros(5,5,laneSize);
delIn(1:2,1,:) = randi([0 1], 2,1, laneSize);

state2 = bitxor(state1, delIn);
state2(3,1,:) = mod(state2(1,1,:) + state2(2,1,:), 2);

delIn = bitxor(state1,state2);

stateC1 = theta(state1,laneSize);
stateC1 = rho(stateC1,laneSize,0);
stateC1 = pie(stateC1,laneSize,0);
stateC1 = chi(stateC1,laneSize,0);

stateC2 = theta(state2,laneSize);
stateC2 = rho(stateC2,laneSize,0);
stateC2 = pie(stateC2,laneSize,0);
stateC2 = chi(stateC2,laneSize,0);

% getStateBitv(delIn,laneSize)

delOut = bitxor(stateC1,stateC2);
% getStateBitv(delOut,laneSize)
end

