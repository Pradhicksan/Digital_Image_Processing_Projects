function [huffmanTable, encodedData] = HuffmanEncodeDC(dcArray)
    % HuffmanEncodeDC: Encodes DC coefficients using Huffman coding.
    % Inputs:
    %   - dcArray: Array of DC difference values (raw DC coefficients).
    % Outputs:
    %   - huffmanTable: Huffman dictionary for encoding.
    %   - encodedData: Encoded binary sequence.

    % Step 1: Calculate the differences between consecutive elements
    % First element is kept as it is, subsequent elements are the differences
    differences = diff(dcArray);
    dcDifferences = [dcArray(1), differences]; % Include the first element
    
    % Step 2: Count the frequency of each unique DC difference value
    [symbols, ~, idx] = unique(dcDifferences);  % Get unique values and their indices
    frequencies = histcounts(idx, 1:length(symbols) + 1);  % Count frequencies

    % Step 3: Normalize the frequencies to get probabilities
    totalFreq = sum(frequencies);
    probabilities = frequencies / totalFreq;
    
    % Ensure all probabilities are positive (Huffman coding requires this)
    assert(all(probabilities > 0), 'All symbols must have non-zero probabilities.');
    
    % Step 4: Generate Huffman Dictionary (huffmanTable)
    huffmanTable = huffmandict(symbols, probabilities);
    %disp(huffmanTable);
    %disp(dcDifferences);
    % Step 5: Encode the DC difference values
    encodedData = huffmanenco(dcDifferences, huffmanTable);
end

