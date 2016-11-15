kitten = rgb2gray(imread('kitten.jpg'));

N = input('Input the size of the convolution matrix, i.e. 1, 4, 2000: ');

kitten_blur = lpf(kitten,N);

imshow(kitten_blur)