function prob = error_probability( cycles, bit_e_p)
% cycles = 10;
message_bits = 0;
correct_bits = 0;
message_book = generate_binary_values(3);

for i = 1:cycles
    message = message_book(randi(size(message_book,1)),:);
    encoded = encoder_633(message);
   
    error = error_channel(encoded, bit_e_p);
    
    decoded = syndrome_decoding(error);
    message_bits = message_bits + 3;
    
    correct_bits = correct_bits + 3 - distance(message, decoded);
    
end

prob = (message_bits - correct_bits) / message_bits;
end