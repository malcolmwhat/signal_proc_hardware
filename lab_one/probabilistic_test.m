clear; clc;

flip_probs = [0.2, 0.15, 0.1, 0.05, 0.01];
erro_probs = zeros(size(flip_probs));
for i = 1: size(flip_probs,2)
    erro_probs(i) = error_probability(1000, flip_probs(i));
end

figure
loglog(flip_probs, erro_probs, '-s')
grid on
xlabel('Bit flip error probability');
title('Probability of decoding error vs probability of bit flip error during transmission');
ylabel('Decoded bit error probability');
xlim([0.009 0.25]);