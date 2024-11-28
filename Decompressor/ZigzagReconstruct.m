function matrix = ZigzagReconstruct(array, n)
    % Reconstruct the matrix from a zigzag traversal array
    % Inputs:
    %   - array: The array obtained from zigzag traversal
    %   - n: Size of the original matrix (n x n)
    
    % Initialize the matrix
    matrix = zeros(n, n);  % Create an empty matrix
    
    % Initialize array index for traversing the input array
    array_index = 1;
    
    % Reconstruct the matrix following the zigzag pattern across diagonals
    for sum_idx = 1:(2 * n - 1)
        if mod(sum_idx, 2) == 0
            % Traverse top-left to bottom-right on even diagonals
            for i = max(1, sum_idx - n + 1):min(n, sum_idx)
                j = sum_idx - i + 1;
                matrix(i, j) = array(array_index);
                array_index = array_index + 1;
            end
        else
            % Traverse bottom-right to top-left on odd diagonals
            for j = max(1, sum_idx - n + 1):min(n, sum_idx)
                i = sum_idx - j + 1;
                matrix(i, j) = array(array_index);
                array_index = array_index + 1;
            end
        end
    end
end
