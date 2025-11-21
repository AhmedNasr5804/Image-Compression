function [out] = IDCT(X)
%IDCT Summary of this function goes here
%   This function performs a 1D Inverse Discrete Cosine Transform (Type-III),
%   which is the inverse of the DCT Type-II used above.

N = length(X);
out = zeros(1, N);

% Perform the IDCT calculation
for n = 0:N-1
    sum_val = 0;
    for k = 0:N-1
        % The scaling factor c(k) is now inside the summation
        if k == 0
            c_k = sqrt(1/N);
        else
            c_k = sqrt(2/N);
        end
        sum_val = sum_val + c_k * X(k+1) * cos(pi * (n + 0.5) * k / N);
    end
    out(n+1) = sum_val;
end

end