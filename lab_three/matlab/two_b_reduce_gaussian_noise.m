kitten = rgb2gray(imread('kitten.jpg'));

snr = input('Specify snr: ');

figure
kitten_noise = awgn(kitten, snr);
imshow(kitten_noise);

figure
kitten_lpf_3 = lpf(kitten_noise, 3);
imshow(kitten_lpf_3);

figure
kitten_lpf_5 = lpf(kitten_noise, 5);
imshow(kitten_lpf_5);