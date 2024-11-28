function [huffmanTable, encodedData] = HuffmanEncodeACValue(acValue)
    % HuffmanEncodeACValue: Encodes AC run-length values using Huffman coding.
    % Inputs:
    %   - acValue: Array of AC run-lengths (from RLE).
    % Outputs:
    %   - huffmanTable: Huffman dictionary for encoding.
    %   - encodedData: Encoded binary sequence (bit sequence as string).
    % Step 1: Count the frequency of each unique run-length value
    [uniqueSymbols, ~, idx] = unique(acValue);
    frequencies = accumarray(idx, 1); % Count occurrences of each unique value

    % Step 2: Normalize the frequencies to get probabilities
    totalFreq = sum(frequencies);
    probabilities = frequencies / totalFreq;

    % Step 3: Generate the Huffman dictionary (huffmanTable)
    huffmanTable = huffmandict(uniqueSymbols, probabilities);

    % Step 4: Encode the run-length values using the Huffman dictionary
    encodedData = huffmanenco(acValue, huffmanTable);

end
