function [out] = DCT(x)
%DCT Summary of this function goes here
%   This function performs a 1D Discrete Cosine Transform (Type-II) for the
%   input signal. This is the standard version used in JPEG compression.

N = length(x);
out = zeros(1, N);

% Perform the DCT calculation
for k = 0:N-1
    sum_val = 0;
    for n = 0:N-1
        sum_val = sum_val + x(n+1) * cos(pi * (n + 0.5) * k / N);
    end
    
    % Apply the scaling factor c(k)
    if k == 0
        % c(0) = sqrt(1/N)
        out(k+1) = sum_val * sqrt(1/N);
    else
        % c(k) = sqrt(2/N) for k > 0
        out(k+1) = sum_val * sqrt(2/N);
    end
end

end