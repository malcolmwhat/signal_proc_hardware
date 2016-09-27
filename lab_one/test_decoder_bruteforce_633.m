%% Test the bruteforce decoding
% Tests the entire message encoding and decoding pipeline. 
function test_decoder_bruteforce_633 ()
% First generate a list of all binary messages of length 3
A = generate_binary_values(3);

% Encode all message using the (6,3,3) code
enc = encoder_633(A);

% Apply erasures to the generated codewords
out = [];
for i = 1:size(enc, 1)
out = [out; erasure_channel(enc(i,:), 0.4)];
end

% Attempt to decode the words and recover from erasures
for index = 1:size(out,1)
decode_bruteforce(out(index,:), 3);
end
end