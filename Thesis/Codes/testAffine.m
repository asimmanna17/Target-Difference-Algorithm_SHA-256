y = [12 15 29 30];

  y = [1     9    11    17];

A = dec2bin(y,5) - '0';

[A1, A2] = licols(A);

% R1=1;
% for I=1:size(A,1)
%     R2=rank(A(1:I,:));
%     if R2~=R1; disp(I);  end
%     R1=R2+1;
% end

% 
% N = size(A,1) ;                  % number of rows
% IncludeTF = false(N,1) ;         % by default, exclude all rows, except ...
% IncludeTF(1) = true ;            % first row which can always be included
% R0 = rank(A) ;                   % the original rank
% for k = 2:N,                     % loop over all rows
%    B = A(IncludeTF,:) ;          % select the currently included rows of A
%    IncludeTF(k) = rank(B) < R0 ; % include in B when the rank is less
% end
% isequal(rank(B), R0)             % check!