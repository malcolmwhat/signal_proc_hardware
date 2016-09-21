function [ output_args ] = decode_bruteforce( code, message_width )
%DECODE Decode back to the original message. Finds the closest codewords
% and determines what message they each encode.
%
% Arguments:
%   code: 6 bit vector code, can contain errors and erasures
%   message_width: width of the expected message, used to select which
%   encoder to use for codebook generation.
%
% Return:
%   output_args: matrix where each row is a closest match to the possible
%   message. Outputs a single message is there is abest match, a list
%   otherwise.
%
% Note: this algorithm is valid regardless of the size of the codeword,
% only the encoder generating the codelist needs to change to accomodate
% different message lenghts.

   values = generate_binary_values(message_width);
   switch (message_width)
       case 2
           codelist = encoder_322(values);
       case 3
           codelist = encoder_633(values); 
       otherwise
           error('\tMessage width %d not supported',message_width)
   end

    dist_i = zeros(size(codelist,1),1);
    for codelist_i = 1:size(codelist,1)
        dist_i(codelist_i) = distance(code,codelist(codelist_i,:)); 
    end
    dist_min = min(dist_i);
    output_args = [];
    for i = 1:size(dist_i)
       if (dist_i(i) == dist_min)
           output_args = [output_args; values(i,:)];
       end
    end
end

