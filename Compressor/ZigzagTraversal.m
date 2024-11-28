function array = ZigzagTraversal(matrix)
    % Get the size of the matrix
    n = size(matrix, 1);
    
    % Initialize parameters
    array = zeros(n * n, 1);  % Result array to hold elements in zigzag order
    array_index = 1;          % Index for storing elements in result array

    % Zigzag traversal across diagonals
    for sum_idx = 1:(2 * n - 1)
        if mod(sum_idx, 2) == 0
            % Traverse top-left to bottom-right on even diagonals
            for i = max(1, sum_idx - n + 1):min(n, sum_idx)
                j = sum_idx - i + 1;
                array(array_index) = matrix(i, j);
                array_index = array_index + 1;
            end
        else
            % Traverse bottom-right to top-left on odd diagonals
            for j = max(1, sum_idx - n + 1):min(n, sum_idx)
                i = sum_idx - j + 1;
                array(array_index) = matrix(i, j);
                array_index = array_index + 1;
            end
        end
    end
end
