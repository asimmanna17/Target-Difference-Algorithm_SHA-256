function f = checkAffineSubspaceNew (inp)

    dimension = size(inp, 2);

    indexs = nchoosek(1:dimension, 4);

    combinations = nchoosek(dimension, 4);
    
    x = sym('x', [1 5]); %to return the equations

    candInd = 1;
    for i = 1:combinations
        ind = indexs(i,:);
        candidate = inp(ind);
        
        binCand = dec2bin(candidate,5) - '0';

        sumCand = sum(binCand);
        
        eq = [];
        
        numConstants = sum(sumCand == 0 | sumCand == 4);

        if(numConstants == 3)
%             'Affine'
            eq = [eq, x(sumCand == 0) == 0];
            eq = [eq, x(sumCand == 4) == 1];
            f{candInd,1} = candidate;
            f{candInd,2} = eq;
            candInd = candInd + 1;
        elseif(numConstants == 2)
            
            remainInd = find(sumCand ~= 0 & sumCand ~= 4);
            
            binCand1 = binCand(:,remainInd(1));
            binCand2 = binCand(:,remainInd(2));
            binCand3 = binCand(:,remainInd(3));
            
            sum12 = sum(bitxor(binCand1, binCand2));
            sum13 = sum(bitxor(binCand1, binCand3));
            sum23 = sum(bitxor(binCand2, binCand3));
            sum123 = sum(bitxor(bitxor(binCand1, binCand2), binCand3));
        
            flag = 0; % to detect xi + xj == 0 or xi + xj == 1
            if(sum12 == 0 || sum12 == 4 || sum13 == 0 || sum13 == 4 || sum23 == 0 || sum23 == 4 || sum123 == 0 || sum123 == 4)
                flag = 1;
%                 'Affine'
            end
            if(flag == 0) 
                continue;
            end
            
            eq = [eq, x(sumCand == 0) == 0];
            eq = [eq, x(sumCand == 4) == 1];
            
            if(sum12 == 0)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) == 0];
            elseif(sum12 == 4)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) == 1];
            end
            
            if(sum13 == 0)
                eq = [eq, x(remainInd(1)) + x(remainInd(3)) == 0];
            elseif(sum13 == 4)
                eq = [eq, x(remainInd(1)) + x(remainInd(3)) == 1];
            end
            
            if(sum23 == 0)
                eq = [eq, x(remainInd(2)) + x(remainInd(3)) == 0];
            elseif(sum23 == 4)
                eq = [eq, x(remainInd(2)) + x(remainInd(3)) == 1];
            end
            
            if(sum123 == 0)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) + x(remainInd(3)) == 0];
            elseif(sum123 == 4)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) + x(remainInd(3)) == 1];
            end
            
            f{candInd,1} = candidate;
            f{candInd,2} = eq;
            candInd = candInd + 1;
            
        elseif(numConstants == 1 || numConstants == 0)
            
            remainInd = find(sumCand ~= 0 & sumCand ~= 4);
            
            numInd = 5 - numConstants;
            
            choicesnc2 = nchoosek(1:numInd, 2);
            choicesnc3 = nchoosek(1:numInd, 3);
            choicesnc4 = nchoosek(1:numInd, 4);


            nc2 = nchoosek(numInd, 2);
            nc3 = nchoosek(numInd, 3);
            nc4 = nchoosek(numInd, 4);
             
            count = 0;
            eqCand = [];
            for iter = 1:nc2+nc3+nc4
                if(iter<= nc2)
                    choice = remainInd(choicesnc2(iter,:));
                    sumChoice = sum(mod(sum(binCand(:,choice),2),2));
                    if(sumChoice == 0 || sumChoice == 4)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/4];                    
                        count = count + 1;                        
                    end
                elseif(iter>nc2 && iter<=nc2+nc3)
                    choice = remainInd(choicesnc3(iter-nc2,:));
                    sumChoice = sum(mod(sum(binCand(:,choice),2),2));
                    
                    if(sumChoice == 0 || sumChoice == 4)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/4];                    
                        count = count + 1;                        
                    end
                elseif(iter>nc2+nc3)
                    choice = remainInd(choicesnc4(iter-nc2-nc3,:));
                    sumChoice = sum(mod(sum(binCand(:,choice),2),2));
                    
                    if(sumChoice == 0 || sumChoice == 4)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/4];                    
                        count = count + 1;                        
                    end
                end
                if((numConstants == 1 && count == 2)||(numConstants == 0 && count == 3))
                    
                    if(numConstants == 0) 
                        LHS = mod(lhs(eqCand(1)) + lhs(eqCand(2)) + lhs(eqCand(3)),2);
                        RHS = mod(rhs(eqCand(1)) + rhs(eqCand(2)) + rhs(eqCand(3)),2);
                        if(LHS == RHS)
%                             disp('gotcha')
                            break;
                        end
                    end
                    
                    eq = [eq, x(sumCand == 0) == 0];
                    eq = [eq, x(sumCand == 4) == 1];
                    
                    eq = [eq, eqCand];                                   
                    
%                     disp(rank(equationsToMatrix(eq, x)))

                    f{candInd,1} = candidate;
                    f{candInd,2} = eq;
                    candInd = candInd + 1;
                    break;
                end
            end
            
        end     
    end
end