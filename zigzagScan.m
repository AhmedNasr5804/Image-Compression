function vec = zigzagScan(block)
%ZIGZAGSCAN Summary of this function goes here
%   Detailed explanation goes here
% Simple zigzag scanning using MATLAB's natural indexing
    n = size(block, 1);
    vec = [];
    
    % Scan diagonals
    for s = 2:2*n
        if mod(s, 2) == 0
            % Even diagonal - go up
            for i = max(1, s-n):min(s-1, n)
                j = s - i;
                vec = [vec, block(i, j)];
            end
        else
            % Odd diagonal - go down
            for i = min(s-1, n):-1:max(1, s-n)
                j = s - i;
                vec = [vec, block(i, j)];
            end
        end
    end
end