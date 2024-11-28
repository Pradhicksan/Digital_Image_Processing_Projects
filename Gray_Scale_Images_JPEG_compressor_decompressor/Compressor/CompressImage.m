function CompressImage(im, q_value)
    % finding the size of the image
    [org_height,org_width] = size(im);

    % finding quantization matrix for this case
    quant_mat = QuantMatCalc(q_value);

    % padding the image
    im = double(PadIm(im)) - 128;

    % finding the sizes to loop through patches
    [height,width] = size(im);
    i_max = height/8;
    j_max = width/8;
    patch_count = i_max*j_max;


    % preallocating dc coefficients and ac coefficients array
    dc_coef = zeros(1,patch_count);
    ac_coef = zeros(1, patch_count*63);

    % looping through patches
    for i =1:i_max
        for j = 1:j_max
            % accessing patches
            patch = im((i-1)*8+1:(i-1)*8+8,(j-1)*8+1:(j-1)*8+8);

            % finding correspoding dct coeff and quantized dct coeff
            dct_coef = DctCalc(patch);  
            quant_dct_coef =  round(dct_coef./quant_mat);
            
            % flatening the matrix by traversing zigzag
            flat_coef = ZigzagTraversal(quant_dct_coef);

            % storing the dc and ac coef in corresponding arrays
            dc_coef((i-1)*j_max+j) = flat_coef(1);
            ac_coef((i-1)*j_max*63+(j-1)*63+1:(i-1)*j_max*63+(j-1)*63+63) = flat_coef(2:64);
        end
    end


    % huffman encoding dc coef
    [dc_huffman_table, dc_encoded_data] = HuffmanEncodeDC(dc_coef);

    % finding the total length of value and run length arrays to
    % preallocate arrays
    run_length_size = 0;
    for i = 1:patch_count
        [run_length, value] = RunLengthEncode(ac_coef(63*(i-1)+1):ac_coef(63*(i-1)+63));
        run_length_size = run_length_size + numel(run_length);
    end
    
    % preallocating run_length and value arrays
    ac_value = zeros(1,run_length_size);
    ac_run_length = zeros(1,run_length_size);

    % looping through ac coef and filling up ac and run_length values
    ac_index = 1;
    for i = 1:patch_count
        [run_length, value] = RunLengthEncode(ac_coef(63*(i-1)+1:63*(i-1)+63));
        run_length_size = numel(run_length);
        ac_run_length(ac_index:ac_index+run_length_size-1) = run_length;
        ac_value(ac_index:ac_index+run_length_size-1) = value;
        ac_index = ac_index + run_length_size;
    end


    % huffman encoding ac value array
    [ac_value_huffman_table, encoded_ac_value] = HuffmanEncodeACValue(ac_value);

    % Convert to logical array (1 bit per element)
    dc_encoded_data = logical(dc_encoded_data);
    ac_run_length = uint8(ac_run_length);
    encoded_ac_value = logical(encoded_ac_value);

    %{
        All the required quantities are computed
            1. dc_huffman_table
            2. dc_encoded_data
            3. encoded_ac_run_length
            4. ac_value_huffman_table
            5. encoded_ac_value
        Saving them in a file
    %}

    % Name of the .mat file where variables will be stored
    output_folder_path = "\Output_files\";
    filename = sprintf('%scompressed_image_dataq%d.mat',output_folder_path, q_value);

    % Saving the variables to the .mat file
    save(filename, 'dc_encoded_data', 'dc_huffman_table','ac_value_huffman_table', 'ac_run_length', 'encoded_ac_value','org_height','org_width','height','width');
    
    % Confirmation message
    disp(['Variables have been saved to ', filename]);



