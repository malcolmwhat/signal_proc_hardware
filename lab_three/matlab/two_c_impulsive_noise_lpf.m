%% Question 2 c
kitten = rgb2gray(imread('kitten.jpg'));

noisy_kitty = impulsive_noise(kitten, 0.1);

figure
subplot(1,3,1);
imshow(noisy_kitty);

% Attempt noise reduction using 3x3 lpf
quiet_kitty3 = lpf(noisy_kitty,3);

subplot(1,3,2);
imshow(quiet_kitty3);

% Attempt noise reduction using 5x5 lpf
quiet_kitty5 = lpf(noisy_kitty,5);

subplot(1,3,3);
imshow(quiet_kitty5);