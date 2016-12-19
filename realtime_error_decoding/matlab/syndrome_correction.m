function [ r_hat ] = syndrome_correction( r, H, n )
% Attempt to syndrome decode the (16,5,8) Reed-Muller Code.
% r: The input code.
% H: The parity check matrix used for syndrome decoding.
% n: The max number of errors we should expect to correct.


% Generate the syndromes.
error_vectors = [zeros(1,length(r))];
for i = 1:n
    error_vectors = vertcat(error_vectors,permpos(i,length(r)));
end

syndrome_table = mod(error_vectors*H',2);

% Get the syndrome of the input vector.
rec_syndrome = mod(r* ',2);

% Check for the syndrome in our syndrome table.
synd_row = ismember(syndrome_table,rec_syndrome,'rows');

if isempty(error_vectors(synd_row,:))
    r_hat = r;
else
    r_hat = mod(error_vectors(synd_row,:)+r,2);
end
end
