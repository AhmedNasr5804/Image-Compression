function report = compareTransform(originalBlocks, customTransformedBlocks, transformType)
%COMPARETRANSFORM Compares a custom transform against MATLAB's built-in function.
%
%   report = compareTransform(originalBlocks, customTransformedBlocks, 'dft')
%   Compares each block in 'customTransformedBlocks' (from your DFT2) with
%   the result of MATLAB's built-in fft2 on the corresponding block in
%   'originalBlocks'.
%
%   report = compareTransform(originalBlocks, customTransformedBlocks, 'dct')
%   Compares each block in 'customTransformedBlocks' (from your DCT2) with
%   the result of MATLAB's built-in dct2 on the corresponding block in
%   'originalBlocks'.
%
% Inputs:
%   originalBlocks        - Cell array of original image blocks (e.g., blocks8).
%   customTransformedBlocks - Cell array of blocks transformed by your custom function.
%   transformType         - String, either 'dft' or 'dct'.
%
% Output:
%   report                - A cell array of structures, where each structure
%                           contains error metrics for a corresponding block.

% Validate the transform type input
if ~strcmpi(transformType, 'dft') && ~strcmpi(transformType, 'dct')
    error('Invalid transformType. Please use ''dft'' or ''dct''.');
end

% Get dimensions of the block grid
[numRows, numCols] = size(originalBlocks);

% Pre-allocate the report cell array
report = cell(numRows, numCols);

% Determine the reference MATLAB function based on the input type
switch lower(transformType)
    case 'dft'
        referenceFunc = @fft2;
    case 'dct'
        referenceFunc = @dct2;
end

% Loop through each block and compare
for r = 1:numRows
    for c = 1:numCols
        
        % Get the custom transformed block
        customBlock = customTransformedBlocks{r, c};
        
        % Get the reference block using MATLAB's built-in function
        originalBlock_double = double(originalBlocks{r, c});
        matlabBlock = referenceFunc(originalBlock_double);
        
        % --- Calculate Error Metrics ---
        
        % Absolute difference
        diff = customBlock - matlabBlock;
        
        % Maximum absolute error
        maxAbsError = max(abs(diff(:)));
        
        % Root Mean Square (RMS) error
        rmsError = sqrt(mean(abs(diff(:)).^2));
        
        % Maximum magnitude error
        magError = abs(abs(customBlock(:)) - abs(matlabBlock(:)));
        maxMagError = max(magError);
        
        % Phase error (less relevant for DCT but included for consistency)
        phaseError = angle(customBlock(:)) - angle(matlabBlock(:));
        phaseErrorStd = std(phaseError);
        
        % Relative error
        relError = norm(diff(:)) / norm(matlabBlock(:));
        
        % Store the results in a structure
        report{r, c} = struct(...
            'maxAbsError', maxAbsError, ...
            'rmsError', rmsError, ...
            'maxMagError', maxMagError, ...
            'phaseErrorStd', phaseErrorStd, ...
            'relError', relError ...
        );
    end
end
end