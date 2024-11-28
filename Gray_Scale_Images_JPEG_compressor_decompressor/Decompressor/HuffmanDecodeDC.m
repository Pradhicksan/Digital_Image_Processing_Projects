function decodedData = HuffmanDecodeDC(encodedData, huffmanTable)
    % HuffmanDecodeDC: Decodes a binary sequence encoded with Huffman coding for DC coefficients.
    % Inputs:
    %   - encodedData: Encoded binary sequence (bit sequence as logical array).
    %   - huffmanTable: Huffman dictionary used for encoding.
    % Output:
    %   - decodedData: Decoded array of DC coefficients.

    % Step 1: Decode the encoded data using the Huffman dictionary
    dcDifferences = huffmandeco(encodedData, huffmanTable);

    % Step 2: Reconstruct the original DC coefficients
    % The first element remains as is, the rest are cumulative sums of differences
    decodedData = cumsum(dcDifferences);
end
