function [out] = IDFT2(X)
%IDFT2 Summary of this function goes here
%   This function performs a 2D-Inverse DFT by applying 1D-IDFT to rows
%   and then to columns.

arguments (Input)
    X
end

arguments (Output)
    out
end

[n1, n2] = size(X);
out = zeros(n1, n2);

% Apply 1D IDFT to each row
for row = 1:n1
    out(row, :) = IDFT(X(row, :));
end

% Apply 1D IDFT to each column of the intermediate result
for col = 1:n2
    out(:, col) = IDFT(out(:, col));
end

end