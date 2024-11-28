function decodedData = HuffmanDecodeACValue(encodedData, huffmanTable)
    % HuffmanDecodeACValue: Decodes a binary sequence encoded with Huffman coding.
    % Inputs:
    %   - encodedData: Encoded binary sequence (bit sequence as logical array).
    %   - huffmanTable: Huffman dictionary used for encoding.
    % Output:
    %   - decodedData: Decoded array of AC run-length values.

    % Step 1: Decode the encoded data using the Huffman dictionary
    decodedData = huffmandeco(encodedData, huffmanTable);
end
