function [out] = DCT2(X)
%DCT2 Summary of this function goes here
%   This function performs a 2D Discrete Cosine Transform by applying 1D-DCT
%   to rows and then to columns.

arguments (Input)
    X
end

arguments (Output)
    out
end

[n1, n2] = size(X);
out = zeros(n1, n2);

% Apply 1D DCT to each row
for row = 1:n1
    out(row, :) = DCT(X(row, :));
end

% Apply 1D DCT to each column of the intermediate result
for col = 1:n2
    out(:, col) = DCT(out(:, col));
end

end