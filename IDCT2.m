function [out] = IDCT2(X)
%IDCT2 Summary of this function goes here
%   This function performs a 2D Inverse Discrete Cosine Transform by applying
%   1D-IDCT to rows and then to columns.

arguments (Input)
    X
end

arguments (Output)
    out
end

[n1, n2] = size(X);
out = zeros(n1, n2);

% Apply 1D IDCT to each row
for row = 1:n1
    out(row, :) = IDCT(X(row, :));
end

% Apply 1D IDCT to each column of the intermediate result
for col = 1:n2
    out(:, col) = IDCT(out(:, col));
end

end