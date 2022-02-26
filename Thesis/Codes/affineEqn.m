function f = affineEqn(subspace)

     x = sum(dec2bin(subspace,5) - '0');
     x(x==4) = 1;
     x(x==1) = 1;
     x(x==2) = Inf;
     x(x==3) = Inf;
 
     f = x;
    
  
end