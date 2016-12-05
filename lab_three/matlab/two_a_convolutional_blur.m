boon = rgb2gray(imread('boon.jpg'));

N = input('Input the size of the convolution matrix, i.e. 1, 4, 2000: ');

kitten_blur = lpf(boon,N);

imshow(kitten_blur)
