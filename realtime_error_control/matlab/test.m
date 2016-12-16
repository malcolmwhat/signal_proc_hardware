%% Test the bit error rates of current implementation.

% Set up all possible vectors to test with.
test_vectors = [
    zeros(1,5);
    permpos(1,5);
    permpos(2,5);
    permpos(3,5);
    permpos(4,5);
    ones(1,5)
];
[ n0_test_vectors, x_ ] = size(test_vectors);

% Set parameters for the noisy channel equation.
N = 16;
era_bins = 5;
err_bins = 5;
itt_per_test = 5;

bit_error_rates = zeros(era_bins,err_bins);
erasure_probabilities = zeros(1,era_bins);
error_probabilities = zeros(1,err_bins);

completion = 0;
waitbar(completion, 'Percent Complete');

for era = 1:era_bins
    completion = completion + 1/era_bins;
    waitbar(completion);
    
    % Set the erasure probability.
    P_era = era / (2 * era_bins);
    erasure_probabilities(era) = P_era;
    
    for err = 1:err_bins
        % Set the error probability.
        P_err = err / (2 * err_bins);
        error_probabilities(err) = P_err;
        
        % Counters.
        number_of_errors = 0; % in bits
        correct = 0; % in bits
        total_words_sent = 0;

        % Encode each test vector, apply noise to the vector, attempt to
        % decode and keep track of the number of bits which were correctly
        % decoded.
        for i=1:n0_test_vectors
            s = encode(test_vectors(i,:));

            % Run this inner loop 10 times so that our error rate converges
            % in probability to its mean value. Increasing this gives us a
            % closer approximation to the mean of the bit error rate, but
            % also slows things down a lot.
            for j=1:itt_per_test
                
                % Author of this section: Yi Feng, TA.
                %%%Error prob. and erasure prob.can be setup in this method
                %%%N is the vector size
                noise=randsrc(1,N,[-1/2 1 0; P_era, P_err, 1-P_err-P_era]);
                r=mod(abs(s+noise),2);
                % End of code authored by Yi Feng.

                m_hat = decode(r);

                number_of_errors = number_of_errors + sum(r~=s);
                correct = correct + sum(m_hat==test_vectors(i,:));
                total_words_sent = total_words_sent + 1;
            end
        end

        mean_number_of_errors = number_of_errors / total_words_sent;
        bit_error_rate = 100 - correct * 100 / (5 * total_words_sent);
        
        bit_error_rates(era,err) = bit_error_rate;
    end
end

figure
surf(error_probabilities, erasure_probabilities, bit_error_rates);
title('Bit Error Curve in Presence of Erasures and Errors');
xlabel('Probability of Error');
ylabel('Probability of Erasure');
zlabel('Bit Error Rate');