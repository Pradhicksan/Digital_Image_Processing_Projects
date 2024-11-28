function pad_im = PadIm(im)

    [height, width] = size(im);
    
    % Calculate padding needed
    padHeight = mod(8 - mod(height, 8), 8);
    padWidth = mod(8 - mod(width, 8), 8);
    
    % Pad the image
    pad_im = padarray(im, [padHeight, padWidth], 'replicate', 'post');

