%% High pass the original image and show the results
boon = rgb2gray(imread('boon.jpg'));

boon_hp = hpf(boon);

%% Display
figure
subplot(1,2,1);
imshow(boon);

subplot(1,2,2);
imshow(boon_hp);