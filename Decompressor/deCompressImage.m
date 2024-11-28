function im_reconstructed = deCompressImage(path,q_value)
    % Load the compressed data from the .mat file

    load(path, 'dc_encoded_data', 'dc_huffman_table', ...
         'ac_value_huffman_table', 'ac_run_length', 'encoded_ac_value', ...
         'org_height', 'org_width', 'height', 'width');
    
    % Convert logical arrays to double for decoding
    dc_encoded_data = double(dc_encoded_data);  % Convert from logical to double
    encoded_ac_value = double(encoded_ac_value);  % Convert from logical to double

    % Initialize reconstructed image
    im_reconstructed = zeros(height, width);

    % Decode DC coefficients
    dc_coef = HuffmanDecodeDC(dc_encoded_data, dc_huffman_table);

    % Decode AC values
    ac_value = HuffmanDecodeACValue(encoded_ac_value, ac_value_huffman_table);

    % Initialize indices for decoding AC coefficients
    patch_count = (height / 8) * (width / 8); % Total number of 8x8 blocks
    ac_index = 1;

    % Loop through each patch to reconstruct the image
    quant_mat = QuantMatCalc(q_value); % Assume q_value for quantization matrix

    for patch_idx = 1:patch_count
        % Decode AC coefficients for the current patch
        current_ac_values = [];

        while ac_index <= numel(ac_run_length) && numel(current_ac_values) <= 63
            run_length = ac_run_length(ac_index);
            value = ac_value(ac_index);
            % Exit the loop if both run_length and value are zero
            ac_index = ac_index + 1;
            if run_length == 0 && value == 0
               break;
            end

          

            % Add zeros for the run length, then append the value
            current_ac_values = [current_ac_values, zeros(1, run_length), value]; %#ok<AGROW>
        end

        % Ensure the AC coefficients are exactly 63 in length
        current_ac_values = [current_ac_values, zeros(1, 63 - numel(current_ac_values))];

        % Combine DC and AC coefficients
        flat_coef = [dc_coef(patch_idx), current_ac_values];

        % Reconstruct the quantized DCT coefficients
        quant_dct_coef = ZigzagReconstruct(flat_coef, 8);  % Assuming 8x8 block size
        %disp(quant_dct_coef);
        % Dequantize the coefficients
        dct_coef = quant_dct_coef .* quant_mat;
        %disp(dct_coef);
        % Reconstruct the spatial domain patch
        patch = IDctCalc(dct_coef);

        % Determine the block's position in the image
        i = ceil(patch_idx / (width / 8));
        j = mod(patch_idx - 1, width / 8) + 1;

        % Place the patch back into the image
        im_reconstructed((i - 1) * 8 + 1:i * 8, (j - 1) * 8 + 1:j * 8) = patch;
    end

    % Remove padding to get the original image dimensions
    im_reconstructed = im_reconstructed(1:org_height, 1:org_width)+128;


end

