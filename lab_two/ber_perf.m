results = zeros(1,10);
message_bits = zeros(1,10);

for i = 1:10
    x = generate_binary_values(4);
    for j = 1:1000
        ind = ceil(rand() * 16);
        result = two_c_one(awgn(encoder_844(x(ind,:)),i));
        num_errs = sum(xor(x(ind,:), result(1:4)));
        results(i) = results(i) + num_errs;
        message_bits(i) = message_bits(i) + 4;
        
        if results(i) > 100 || message_bits(i) > 10000
            break;
        end
    end
end


bER = results ./ message_bits;

figure
semilogy(1:10,bER)
title('Bit Error Rate vs SNR')
xlabel('SNR in dB')
ylabel('Bit Error Rate')