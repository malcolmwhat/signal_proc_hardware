%% Test the bruteforce decoding
% Tests the entire message encoding and decoding pipeline. 

% First generate a list of all binary messages of length 2
A = generate_binary_values(2);

% Encode all message using the (3, 2, 2) code
enc = encoder_322(A);

% Apply erasures to the generated codewords
erased = [];
for i = 1:size(enc, 1)
erased = [erased; erasure_channel(enc(i,:), 0.3)];
end

% Attempt to decode the words and recover from erasures
for index = 1:size(erased,1)
decode_bruteforce(erased(index,:), 2)
end