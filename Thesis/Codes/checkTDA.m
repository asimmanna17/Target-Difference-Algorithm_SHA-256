% this code is to check the Target difference algo

function f = checkTDA(msg1,delIn,delTIn,laneSize)

% laneSize = 2;

%Round Constants for laneSize = 64
rc(1,:)  = '0000000000000001';
rc(2,:)  = '0000000000008082';
rc(3,:)  = '800000000000808A';
rc(4,:)  = '8000000080008000';
rc(5,:)  = '000000000000808B';
rc(6,:)  = '0000000080000001';
rc(7,:)  = '8000000080008081';
rc(8,:)  = '8000000000008009';
rc(9,:)  = '000000000000008A';
rc(10,:) = '0000000000000088';
rc(11,:) = '0000000080008009';
rc(12,:) = '000000008000000A';
rc(13,:) = '000000008000808B';
rc(14,:) = '800000000000008B';
rc(15,:) = '8000000000008089';
rc(16,:) = '8000000000008003';
rc(17,:) = '8000000000008002';
rc(18,:) = '8000000000000080';
rc(19,:) = '000000000000800A';
rc(20,:) = '800000008000000A';
rc(21,:) = '8000000080008081';
rc(22,:) = '8000000000008080';
rc(23,:) = '0000000080000001';
rc(24,:) = '8000000080008008';


state1 = msg1;      

state2 = bitxor(state1,delIn);       

stateC1 = theta(state1,laneSize);
stateC1 = rho(stateC1,laneSize,0);
stateC1 = pie(stateC1,laneSize,0);
stateC1 = chi(stateC1,laneSize,0);
% for iota
%stateC1(1,1,laneSize) = mod(stateC1(1,1,laneSize) + 1,2);



stateC2 = theta(state2,laneSize);
stateC2 = rho(stateC2,laneSize,0);
stateC2 = pie(stateC2,laneSize,0);
stateC2 = chi(stateC2,laneSize,0);
% for iota
%stateC2(1,1,laneSize) = mod(stateC2(1,1,laneSize) + 1,2);
delTOut = bitxor(stateC1,stateC2);
bitxor(delTOut, delTIn);
if (isequal(delTOut, delTIn))
    disp('successful')
end

% f = state1;

end    



