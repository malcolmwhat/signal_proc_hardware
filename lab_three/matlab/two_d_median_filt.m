%% Apply impulsive noise
boon = rgb2gray(imread('boon.jpg'));

boon_imp_noise = impulsive_noise(boon, 0.2);

%% Call 3x3 median filter
boon_filt_three = mpf(boon_imp_noise, 3);

%% Call 5x5 median filter
boon_filt_five = mpf(boon_imp_noise,5);

%% Display Results
figure
subplot(2,2,1);
imshow(boon);

subplot(2,2,2);
imshow(boon_imp_noise);

subplot(2,2,3);
imshow(boon_filt_three);

subplot(2,2,4);
imshow(boon_filt_five);