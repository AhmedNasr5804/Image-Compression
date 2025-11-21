function [out] = IDFT(X)
%IDFT Summary of this function goes here
%   This function performs a simple 1D-Inverse DFT transformation for the
%   input frequency domain signal.

N = length(X);
out = zeros(1, N);

% Perform the IDFT calculation
% Note the '+' sign in the exponent and the (1/N) scaling factor
for n = 0:N-1
    for k = 0:N-1
        out(n+1) = out(n+1) + X(k+1) * exp(2*pi*1i*k*n/N);
    end
end

% Apply the final 1/N scaling factor
out = out / N;

end