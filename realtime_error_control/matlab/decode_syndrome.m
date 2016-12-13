function [ m ] = decode_syndrome( r )
% Attempt to syndrome decode the (16,5,8) Reed-Muller Code.
G = encode(eye(5));
H = horzcat(G(:,6:16)',eye(11));

% Generate the syndromes.
% Note that permpos is an external permutation lib and considering 
% there are only 560 syndromes we will hardcode the syndromes in
% hardware.
error_vectors = [zeros(1,16);permpos(1,16);permpos(2,16);permpos(3,16)];
syndrome_table = mod(error_vectors*H',2);

% Get the syndrome of the input vector.
rec_syndrome = mod(r*H',2);

% Check for the syndrome in our syndrome table.
synd_row = ismember(syndrome_table,rec_syndrome,'rows');

r_decoded = mod(error_vectors(synd_row,:)+r,2);

m = r_decoded(1:5);
end