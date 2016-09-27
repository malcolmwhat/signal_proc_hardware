%% Script to test and time decoding algorithms for different code lenghts

samples = 100;

%% Test the (3, 2, 2) decoding time
res_1 = zeros(samples,1);
funct = @test_decoder_bruteforce_322;
for i = 1:samples
   res_1(i) = timeit(funct);
end
avg_1 = mean(res_1);

%% Test the (6, 3, 3) decoding time
res_2 = zeros(samples,1);
funct = @test_decoder_bruteforce_633;
for i = 1:samples
   res_2(i) = timeit(funct);
end
avg_2 = mean(res_2);

%% Report status

disp(['Average decoding time for ', num2str(samples), ' samples using (3, 2, 2) code is ', num2str(avg_1), ' seconds'])
disp(['Average decoding time for ', num2str(samples), ' samples using (6, 3, 3) code is ', num2str(avg_2), ' seconds'])