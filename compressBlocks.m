function compressedBlocks = compressBlocks(transformedBlocks, retentionRatio)
%COMPRESSBLOCKS Reduces coefficients in each block for compression.
%
%   compressedBlocks = compressBlocks(transformedBlocks, retentionRatio)
%   Takes a cell array of transformed blocks (DFT or DCT) and a retention
%   ratio (e.g., 0.25 for 25%) and returns a new cell array where each
%   block has been compressed by zeroing out all but the largest
%   coefficients by magnitude.
%
% Inputs:
%   transformedBlocks - Cell array of 2D matrices (transform coefficients).
%   retentionRatio    - Scalar between 0 and 1, the fraction of coefficients to keep.
%
% Output:
%   compressedBlocks  - Cell array of compressed coefficient matrices.

    % Use cellfun to apply the compression logic to each block in the cell array
    compressedBlocks = cellfun(@(block) compress_single_block(block, retentionRatio), ...
                              transformedBlocks, ...
                              'UniformOutput', false);

end

% --- Local helper function that operates on a single block ---
function compressed_block = compress_single_block(block, retentionRatio)
    % Get block dimensions
    [M, N] = size(block);
    totalCoeffs = M * N;

    % Calculate the exact number of coefficients to keep
    k = floor(totalCoeffs * retentionRatio);

    % If k is 0, return a zero matrix of the same size and data type
    if k == 0
        compressed_block = zeros(M, N, 'like', block);
        return;
    end

    % Find the magnitude threshold. We need to find the k-th largest magnitude.
    % 1. Get the magnitude of all coefficients and flatten to a vector.
    mag_vec = abs(block(:));
    % 2. Sort the magnitudes in descending order.
    sorted_mag = sort(mag_vec, 'descend');
    % 3. The threshold is the magnitude of the k-th largest coefficient.
    threshold = sorted_mag(k);

    % Create a logical mask. 'true' for coefficients to keep, 'false' for zeroing.
    % We keep coefficients with a magnitude greater than or equal to the threshold.
    mask = abs(block) >= threshold;

    % Apply the mask to the original block to zero out the rest.
    compressed_block = block .* mask;
end