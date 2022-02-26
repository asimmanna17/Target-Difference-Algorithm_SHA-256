clc
clear

load affineSSKeccak.mat

laneSize = 2;

lMat = getLmat(laneSize);

B = inv(gf(lMat,2));

lDel =  sym('x', [5 5 laneSize]);

lDel = reshape(lDel, 1, []);

e = B.x*lDel.';   % Expression for theta ro pi inv

lDel = reshape(lDel, 5, 5, []); %reshaping to 3D

e = reshape(e, 5, 5, []); %reshaping to 3D

capacitySize = 5*laneSize;

E = (e(5:5,:,:) == 0); %Changed from 4:5 to 5:5 to test affine subspace of solutions

% [delInp, delT] = getDelOut(laneSize);

%  delT = zeros(5,5,laneSize);
% delT(1:3,:,:) = randi([0 1], 3, 5, laneSize); %Changed from 1:2 to 1:3 to check affine subspace of solutions

delT(:,:,1) = [  0     1     0     0     0
                 0     0     1     1     0
                 1     0     0     0     0
                 0     0     0     0     0
                 0     0     0     0     0];
           
delT(:,:,2) = [0     1     0     0     1;
               1     0     1     0     1;
               1     0     0     1     0;
               0     0     0     0     0;
               0     0     0     0     0];       
           
rowSum = sum(delT, 2);
           
for slice = 1:laneSize
    for row = 1:5
        if(rowSum(row,1,slice) == 0) %note rowsum has only one column
             E = subs(E, lDel(row,:,slice),  zeros(1,5));

        end
    end
end

[A_,lastBits] = equationsToMatrix(E, lDel);

X = linsolve(A_,lastBits);

dummy = sym('x', [1 5]);

E = reshape(E, [1 capacitySize]);

consistentDiff = [];

dCnt = 1;
for slice = 1:laneSize
    for row = 1:5
        if(rowSum(row,1,slice) ~= 0) %note rowsum has only one column
            decRow  = bin2dec(num2str(delT(row,:,slice))); 
%             delIns = getDelInputs(decRow);
            affineSS = affineSSKeccak{decRow};
            for ssNum = 1: size(affineSS,1)
                f = affineSS{ssNum, 2}; %getting the affine equations
                vars = lDel(row,:,slice);
                
                newEqns = subs(f, dummy, vars); %translating to current vars
                ETest = [E newEqns];

                [A_,lastBits] = equationsToMatrix(ETest, lDel);
                lastBits = mod(lastBits,2);
                X = gflineq(double(A_),double(lastBits));
                
                if(sum(X)>0)
                    E = ETest;
                    consistentDiff(dCnt,:) = affineSS{ssNum, 1}; %Keeping the consitent affineSS
                    dCnt = dCnt + 1;
                    break;
                end
            end
        end
    end
end


if(sum(X)>0)
    deli = reshape(mod(double(B.x)*X,2), [5 5 laneSize]);
end

disp('done')

