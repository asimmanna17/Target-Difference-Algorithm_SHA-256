function f = getDelInputs(delOut)

% delOut = bin2dec(fliplr(dec2bin(1,5))) + 1;

ddt = getDDT();

delIn = ddt(:,delOut);

ddtNonZeroVals = find(delIn);
ddtVal = delIn(delIn~=0);

% size = size(index);

sortDDTVals = sortrows(horzcat(ddtVal, ddtNonZeroVals - 1 ), -1); % ddtNonZeroVals - 1 to account for matlab indexing from 1

f = sortDDTVals(:,2);

% maxIndex = size(sortDDTVals, 1);
% 
% inpDiff = sortDDTVals(maxIndex,2);
% 
% soln{inpDiff, delOut}
% 
% diffSoln = bin2dec(fliplr(dec2bin(soln{inpDiff, delOut})))';
% 
% subspaces = checkAffineSubspace(diffSoln);
% 
% f = affineEqn(subspaces(1,:));

end