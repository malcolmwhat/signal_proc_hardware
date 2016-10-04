function [ output_args ] = syndrome_decoding( reception_message )
%SYNDROME_DECODING Use syndrome comparaison to identify bit flip errors
%
% Argument:
%   reception_message: message with bit flip error
% Return:
%   output_args: the decoded message

    G = encoder_633(eye(3));
    H = [G(1:size(G,1), size(G,2)/2+1:size(G,2)) G(1:size(G,1), 1:size(G,2)/2)];
    E = eye(6);
    ref_synd = mod(H*E,2);
    synd = mod(H*reception_message',2);
    e_pos = ismember(ref_synd', synd', 'rows');

    for i = 1:size(e_pos, 1)
        if e_pos(i) == 1
            error_vector = E(i,:);
        end
    end
    if exist('error_vector', 'var')
        corrected_message = mod(reception_message + error_vector, 2);
        output_args = corrected_message(1:3);
    else
       output_args = reception_message(1:3);
    end
end
