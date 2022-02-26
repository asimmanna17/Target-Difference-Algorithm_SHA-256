% this code will pre calculate the affine subspace equations for values at
% ddt(delIn,detOut) that is non zero
function f = precomputeAffine
[ddt, soln] = ddtTarget();
affineSet = cell(31);
for delIn = 1:31
    for delOut = 1:31
        disp(delOut)
%         disp(delIn)
        if ddt(delIn+1,delOut+1)
            inputs = soln(delIn+1,delOut+1);
            affineSet{delIn, delOut} = checkAffineSubspaceVal(inputs{1});  
        end
        
    end
end

% save affineSet affineSet
% f = affineSet;
end