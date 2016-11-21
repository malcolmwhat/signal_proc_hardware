kitten = rgb2gray(imread('kitten.jpg'));

snr = input('Specify snr: ');

% Apply noise to the image.
figure
kitten_noise = awgn(kitten, snr);
imshow(kitten_noise);

% Display the results of low pass filtering with 3x3 filter.
figure
kitten_lpf_3 = lpf(kitten_noise, 3);
imshow(kitten_lpf_3);

% Display the results of low pass filtering with 5x5 filter.
figure
kitten_lpf_5 = lpf(kitten_noise, 5);
imshow(kitten_lpf_5);


%% Need to add subplots
K0 = input('Specify cut off frequency between 0 and 2*pi: ');
% FFT result
figure
kitten_lpf_ft = lpf_freq_domain(kitten_noise, K0);
% Take the 2D fft of the noisy image.
imshow(kitten_lpf_ft);