    function [run_length, value] = RunLengthEncode(array)
    array_size = size(array,2);
   run_length = zeros(1,array_size);
    value = zeros(1, array_size);
    index = 1;
    zero_count = 0;

    for i = 1:array_size
        if (array(i) ~= 0) || ((array(i) == 0)&&(zero_count==15))
            run_length(index) = zero_count;
            value(index) = array(i);
            index = index+1;
            zero_count = 0;
        else
            zero_count = zero_count + 1;
        end
    end
    run_length = run_length(1:index-1);
    value = value(1:index-1);

    for i = numel(value):-1:1
        if (value(i) ~= 0) && (i==numel(value))
            run_length = [run_length, 0];
            value = [value, 0];
            break;
        elseif (value(i) ~= 0)
            run_length = run_length(1:i+1);
            value = value(1:i+1);
            run_length(i+1) = 0;
            value(i+1) = 0;
            break;
        elseif i == 1
            run_length = [0];
            value = [0];

        end
    end
