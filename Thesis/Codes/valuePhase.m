% clc
% clear

% equations for 2-D affine subspace are stored, in this first part delins 
% are stored and sec part has eqs

load affineSSKeccak.mat    

% equations for the possible values that satisfy ddt(delin,delout) = n

load affineSet.mat

laneSize = 2;

lMat = getLmat(laneSize);

B = inv(gf(lMat,2));

% varible for system of eq in Em for input values
lmsg =  sym('m', [5 5 laneSize]);

lmsg = reshape(lmsg, 1, []);

e = B.x*lmsg.';   % Expression for theta ro pi inv

lmsg = reshape(lmsg, 5, 5, []); %reshaping to 3D

e = reshape(e, 5, 5, []); %reshaping to 3D

capacitySize = 5*laneSize;

% equation for p||0^2n  bits here 2n = c= 10 and p = 0
M = (e(5:5,:,:) == 0); 

M = reshape(M, [1 capacitySize]);

% affineSet has eq of x's 
dummy = sym('x', [1 5]);

dCnt = 1;

Etry = E; %Restore the original Edelta from diffphase

for slice = 1:laneSize
    for row = 1:5
        if(rowSum(row,1,slice) ~= 0) %note rowsum has only one column
            solnFound = 0; %to track if Edelta is consistent for a sbox

            decRow  = bin2dec(num2str(delT(row,:,slice))); 
             delIns = getDelInputs(decRow+1);

%             consistentSS = consistentDiff(dCnt,:);
            
            %%%We are skipping the sorting as per step 3b: TODO
            
            
            consInpDiff = consistentDiff(dCnt,:); %getting affine input diff sebset for row
            for iter = 1: size(consInpDiff,2)
                inpDiff = consInpDiff(iter); %getting the input difference
                vars = lmsg(row,:,slice);
                f = affineSet(inpDiff,decRow);

                newEqns = subs(f{1}, dummy, vars); %translating to current vars
                MTest = [M newEqns];

                [M_,lastBitsM] = equationsToMatrix(MTest, lmsg);
                lastBitsM = mod(lastBitsM,2);
                Y = gflineq(double(M_),double(lastBitsM));
                
                if(sum(Y)>0)
                    extraEq = additionalEqn(inpDiff);
                    var = lDel(row,:,slice);
                    extraEq = subs(extraEq, dummy, var);
                    ETest = [Etry extraEq];
                    
                    [A_,lastBitsE] = equationsToMatrix(ETest, lDel);
                    lastBitsE = mod(lastBitsE,2);
                    X = gflineq(double(A_),double(lastBitsE));
                    
                    if(sum(X)>0)
                        disp('Soln found')
                        M = MTest;                  
                        Etry = ETest;
                        solnFound = 1;
                        dCnt = dCnt + 1;
                        break;
                    end                                        
                end
            end
            if(solnFound == 0)
                disp('No solun found for row, slice: ')
                disp([row, slice])
                break;
            end
        end        
    end
end

if(sum(X)>0)
    deli = reshape(mod(double(B.x)*X,2), [5 5 laneSize]);
end
if(sum(Y)>0)
    msgIn = reshape(mod(double(B.x)*Y,2), [5 5 laneSize]);
end

% checkTDA(msgIn,deli,delT,laneSize)