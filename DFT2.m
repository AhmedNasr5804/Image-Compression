function [out] = DFT2(X)
%DFT2 Summary of this function goes here
%   Detailed explanation goes here
arguments (Input)
    X
end

arguments (Output)
    out
end

[n1,n2] = size(X);

out = zeros(n1,n2);

for row = 1:n1
    out(row,:) = DFT(X(row,:));
end

for col = 1:n2
    out(:,col) = DFT(out(:,col));
end

end