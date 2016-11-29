%% Question 3 
% A)

image = imread('lena_grey_scale.png');
figure
imshow(spacial_fft(image))

% B)
% Impulse: 
image = zeros(1000, 1000);
image(1,1) = 1;
figure
imshow(spacial_fft(image))

% Constant:
image = ones(1000, 1000);
figure
imshow(spacial_fft(image))

% Jap flag:
image = imread('jap.jpg');
image = rgb2gray(image);
figure
imshow(spacial_fft(image))

% Harmonic:
image = harmonic_image(500, 1);
figure
imshow(spacial_fft(image))

%% Part C)
impulse_image = zeros(1000, 1000);
impulse_image(1,1) = 1;
h_a = lpf(impulse_image, 10);
figure
imshow(spacial_fft(h_a))

h_e = hpf(impulse_image);
figure
imshow(spacial_fft(h_e))

h_d = mpf(impulse_image, 3);
figure
imshow(spacial_fft(h_d))
% that part is useless, it is made to remove impulsive noise, it's impulse
% response is meaningless


