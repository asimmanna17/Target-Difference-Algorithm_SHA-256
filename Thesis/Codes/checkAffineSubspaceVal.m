function f = checkAffineSubspaceVal (inp)

    dimension = size(inp, 2);
    x = sym('x', [1 5]); %to return the equations
    ind = nchoosek(1:dimension, dimension);
    candidate = inp(ind);
    binCand = dec2bin(candidate,5) - '0';
    sumCand = sum(binCand);
    eq = [];
%    when dimension is 8 we need 2  equations

    if (dimension==8)
        
         numConstants = sum(sumCand == 0 | sumCand == dimension);

        if(numConstants == 2)
        %     'Affine'
            eq = [eq, x(sumCand == 0) == 0];
            eq = [eq, x(sumCand == dimension) == 1];
            
        elseif(numConstants == 1 || numConstants == 0)

            remainInd = find(sumCand ~= 0 & sumCand ~= dimension);

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
                    if(sumChoice == 0 || sumChoice == dimension)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/dimension];    
                        count = count + 1;
                    end
                elseif(iter>nc2 && iter<=nc2+nc3)
                    choice = remainInd(choicesnc3(iter-nc2,:));
                    sumChoice = sum(mod(sum(binCand(:,choice),2),2));

                    if(sumChoice == 0 || sumChoice == dimension)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/dimension];    
                        count = count + 1;
                    end
                elseif(iter>nc2+nc3)
                    choice = remainInd(choicesnc4(iter-nc2-nc3,:));
                    sumChoice = sum(mod(sum(binCand(:,choice),2),2));

                    if(sumChoice == 0 || sumChoice == dimension)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/dimension];    
                        count = count + 1;
                    end
                end
                if((numConstants == 1 && count == 1)||(numConstants == 0 && count == 2))

                    if(numConstants == 0) 
                        LHS = mod(lhs(eqCand(1)) + lhs(eqCand(2)) + lhs(eqCand(3)),2);
                        RHS = mod(rhs(eqCand(1)) + rhs(eqCand(2)) + rhs(eqCand(3)),2);
                if(LHS == RHS)
                %     disp('gotcha')
                    break;
                end
                    end

                    eq = [eq, x(sumCand == 0) == 0];
                    eq = [eq, x(sumCand == dimension) == 1];

                    eq = [eq, eqCand];   

                %     disp(rank(equationsToMatrix(eq, x)))

                    
                    break;
                end
            end
        end 
        f = eq(1:2);
    end
    if (dimension==4)

        numConstants = sum(sumCand == 0 | sumCand == dimension);

        if(numConstants == 3)
        %     'Affine'
            eq = [eq, x(sumCand == 0) == 0];
            eq = [eq, x(sumCand == dimension) == 1];
            
        elseif(numConstants == 2)

            remainInd = find(sumCand ~= 0 & sumCand ~= dimension);

            binCand1 = binCand(:,remainInd(1));
            binCand2 = binCand(:,remainInd(2));
            binCand3 = binCand(:,remainInd(3));

            sum12 = sum(bitxor(binCand1, binCand2));
            sum13 = sum(bitxor(binCand1, binCand3));
            sum23 = sum(bitxor(binCand2, binCand3));
            sum123 = sum(bitxor(bitxor(binCand1, binCand2), binCand3));

            eq = [eq, x(sumCand == 0) == 0];
            eq = [eq, x(sumCand == dimension) == 1];

            if(sum12 == 0)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) == 0];
            elseif(sum12 == dimension)
                 eq = [eq, x(remainInd(1)) + x(remainInd(2)) == 1];
            end

            if(sum13 == 0)
                eq = [eq, x(remainInd(1)) + x(remainInd(3)) == 0];
            elseif(sum13 == dimension)
                eq = [eq, x(remainInd(1)) + x(remainInd(3)) == 1];
            end

            if(sum23 == 0)
                eq = [eq, x(remainInd(2)) + x(remainInd(3)) == 0];
            elseif(sum23 == dimension)
                    eq = [eq, x(remainInd(2)) + x(remainInd(3)) == 1];
            end

            if(sum123 == 0)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) + x(remainInd(3)) == 0];
            elseif(sum123 == dimension)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) + x(remainInd(3)) == 1];
            end

            
        elseif(numConstants == 1 || numConstants == 0)

            remainInd = find(sumCand ~= 0 & sumCand ~= dimension);

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
                    if(sumChoice == 0 || sumChoice == dimension)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/4];    
                        count = count + 1;
                    end
                elseif(iter>nc2 && iter<=nc2+nc3)
                    choice = remainInd(choicesnc3(iter-nc2,:));
                    sumChoice = sum(mod(sum(binCand(:,choice),2),2));

                    if(sumChoice == 0 || sumChoice == dimension)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/4];    
                        count = count + 1;
                    end
                elseif(iter>nc2+nc3)
                    choice = remainInd(choicesnc4(iter-nc2-nc3,:));
                    sumChoice = sum(mod(sum(binCand(:,choice),2),2));

                    if(sumChoice == 0 || sumChoice == dimension)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/4];    
                        count = count + 1;
                    end
                end
                if((numConstants == 1 && count == 2)||(numConstants == 0 && count == 3))

                    if(numConstants == 0) 
                        LHS = mod(lhs(eqCand(1)) + lhs(eqCand(2)) + lhs(eqCand(3)),2);
                        RHS = mod(rhs(eqCand(1)) + rhs(eqCand(2)) + rhs(eqCand(3)),2);
                if(LHS == RHS)
                %     disp('gotcha')
                    break;
                end
                    end

                    eq = [eq, x(sumCand == 0) == 0];
                    eq = [eq, x(sumCand == dimension) == 1];

                    eq = [eq, eqCand];   

                %     disp(rank(equationsToMatrix(eq, x)))
%                     f = eq;
                    break;
                    
                end
            end

        end 
        f = eq(1:3);
    end
    
    if (dimension==2)

        numConstants = sum(sumCand == 0 | sumCand == dimension);

        if(numConstants == 4)
        %     'Affine'
            eq = [eq, x(sumCand == 0) == 0];
            eq = [eq, x(sumCand == dimension) == 1];
            
        elseif(numConstants == 3)
            
            eq = [eq, x(sumCand == 0) == 0];
            eq = [eq, x(sumCand == dimension) == 1];
            remainInd = find(sumCand ~= 0 & sumCand ~= dimension);

            binCand1 = binCand(:,remainInd(1));
            binCand2 = binCand(:,remainInd(2));
            sum12 = sum(bitxor(binCand1, binCand2));
            if(sum12 == 0)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) == 0];
            elseif(sum12 == dimension)
                 eq = [eq, x(remainInd(1)) + x(remainInd(2)) == 1];
            end
            
            
        elseif(numConstants == 2)

            remainInd = find(sumCand ~= 0 & sumCand ~= dimension);

            binCand1 = binCand(:,remainInd(1));
            binCand2 = binCand(:,remainInd(2));
            binCand3 = binCand(:,remainInd(3));

            sum12 = sum(bitxor(binCand1, binCand2));
            sum13 = sum(bitxor(binCand1, binCand3));
            sum23 = sum(bitxor(binCand2, binCand3));
            sum123 = sum(bitxor(bitxor(binCand1, binCand2), binCand3));

            eq = [eq, x(sumCand == 0) == 0];
            eq = [eq, x(sumCand == dimension) == 1];

            if(sum12 == 0)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) == 0];
            elseif(sum12 == dimension)
                 eq = [eq, x(remainInd(1)) + x(remainInd(2)) == 1];
            end

            if(sum13 == 0)
                eq = [eq, x(remainInd(1)) + x(remainInd(3)) == 0];
            elseif(sum13 == dimension)
                eq = [eq, x(remainInd(1)) + x(remainInd(3)) == 1];
            end

            if(sum23 == 0)
                eq = [eq, x(remainInd(2)) + x(remainInd(3)) == 0];
            elseif(sum23 == dimension)
                    eq = [eq, x(remainInd(2)) + x(remainInd(3)) == 1];
            end

            if(sum123 == 0)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) + x(remainInd(3)) == 0];
            elseif(sum123 == dimension)
                eq = [eq, x(remainInd(1)) + x(remainInd(2)) + x(remainInd(3)) == 1];
            end

        elseif(numConstants == 1 || numConstants == 0)

            remainInd = find(sumCand ~= 0 & sumCand ~= dimension);

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
                    if(sumChoice == 0 || sumChoice == dimension)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/dimension];    
                        count = count + 1;
                    end
                elseif(iter>nc2 && iter<=nc2+nc3)
                    choice = remainInd(choicesnc3(iter-nc2,:));
                    sumChoice = sum(mod(sum(binCand(:,choice),2),2));

                    if(sumChoice == 0 || sumChoice == dimension)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/dimension];    
                        count = count + 1;
                    end
                elseif(iter>nc2+nc3)
                    choice = remainInd(choicesnc4(iter-nc2-nc3,:));
                    sumChoice = sum(mod(sum(binCand(:,choice),2),2));

                    if(sumChoice == 0 || sumChoice == dimension)
                        eqCand = [eqCand, sum(x(choice)) == sumChoice/dimension];    
                        count = count + 1;
                    end
                end
                if((numConstants == 1 && count == 3)||(numConstants == 0 && count == 4))

                    if(numConstants == 0) 
                        LHS = mod(lhs(eqCand(1)) + lhs(eqCand(2)) + lhs(eqCand(3)),2);
                        RHS = mod(rhs(eqCand(1)) + rhs(eqCand(2)) + rhs(eqCand(3)),2);
                if(LHS == RHS)
                %     disp('gotcha')
                    break;
                end
                    end

                    eq = [eq, x(sumCand == 0) == 0];
                    eq = [eq, x(sumCand == dimension) == 1];

                    eq = [eq, eqCand];   

                %     disp(rank(equationsToMatrix(eq, x)))

                    
                    break;
                end
            end
        end 
        f = eq(1:4);
    end
end
   