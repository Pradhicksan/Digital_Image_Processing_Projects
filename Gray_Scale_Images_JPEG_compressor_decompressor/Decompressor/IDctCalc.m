function patch = IDctCalc(dct_coef)
    % IDctCalc: Computes the 2D Inverse Discrete Cosine Transform (IDCT) of a block.
    % Input:
    %   - dct_coef: A 2D array (8x8 block of DCT coefficients).
    % Output:
    %   - patch: The reconstructed 8x8 block in the spatial domain.

    % Apply 2D Inverse DCT
    patch = idct2(dct_coef);
end
