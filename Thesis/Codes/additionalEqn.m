% this code is for generating equations for the delta input that we are
% taking in value phase

function f = additionalEqn(delIns)
     %delIns = 5;
     m = sym('x', [1 5]);
     bin = (dec2bin(delIns,5) - '0');
     f = [];
     f = [f, m(bin == 0) == 0];
     f = [f, m(bin == 1) == 1];
    
end