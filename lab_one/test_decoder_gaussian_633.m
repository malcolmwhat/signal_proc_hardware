%% Test gaussian decoding

% generate all 3 bit messages
A = generate_binary_values(3);

% apply encoding in 6,3,3 format
enc = encoder_633(A);

% Generate a large data set for each erasure probability trial
messages = [];
data = [];
for i=1:100
    messages = vertcat(messages, A);
    data = vertcat(data,enc);
end

er_probs = [0.001,0.005,0.01,0.02,0.05,0.1,0.2,0.3,0.4];
er_count = [];
% For each of the er_probs
    % Apply the erasure channel for that prob using erprob
    % Decode all erasured entries
    % Count the number of failed decodes

for i = 1:length(er_probs)
    decoder_res = [];
    % apply erasure
    for j = 1:size(data,1)
        er_vect = erasure_channel(data(j,:),er_probs(i));
        decoder_res(j, :) = decoder_gaussian_elim(er_vect);
    end
    
    % Count the number of failed decodes
    check_eqs = messages == decoder_res;
    temp = [];
    for k = 1:size(data,1)
        temp(k) = sum(check_eqs(k,:)) == 3;
    end
    
    er_count(i) = sum(temp == 0);
end

