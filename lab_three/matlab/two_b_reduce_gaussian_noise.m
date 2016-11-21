figure

kitten = rgb2gray(imread('kitten.jpg'));
subplot(1,5,1);
imshow(kitten);

snr = 0;

% Apply noise to the image.
kitten_noise = awgn(kitten, snr);

subplot(1,5,2);
imshow(kitten_noise);

% Display the results of low pass filtering with 3x3 filter.
kitten_lpf_3 = lpf(kitten_noise, 3);

subplot(1,5,3);
imshow(kitten_lpf_3);

% Display the results of low pass filtering with 5x5 filter.
kitten_lpf_5 = lpf(kitten_noise, 5);

subplot(1,5,4);
imshow(kitten_lpf_5);


% Need to add subplots
K0 = 2*pi;
% FFT result
kitten_lpf_ft = lpf_freq_domain(kitten_noise, K0);
% Take the 2D fft of the noisy image.

subplot(1,5,5);
imshow(kitten_lpf_ft);