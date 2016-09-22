%% Test gaussian decoding

% generate all 3 bit messages
A = generate_binary_values(3);

% apply encoding in 6,3,3 format
enc = encoder_633(A);

% Apply erasures to the generated codewords
out = [];
for i = 1:size(enc, 1)
    out = [out; erasure_channel(enc(i,:), 0.5)];
end

% Attempt to decode the words and recover from erasures
for index = 1:size(out,1)
    cur = A(index, :);
    r = out(index, :);
    val = decoder_gaussian_elim(out(index,:));
end