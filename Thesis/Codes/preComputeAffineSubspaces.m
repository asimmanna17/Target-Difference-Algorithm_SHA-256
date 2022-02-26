function f = preComputeAffineSubspaces

    affineSet = cell(1,31);
    for delOut = 1:31
        disp(delOut)
        delIns = getDelInputs(delOut + 1); %Taking care of matlab indexing by + 1
        affineSet{delOut} = checkAffineSubspaceNew(delIns');            
    end
    f = affineSet;
end