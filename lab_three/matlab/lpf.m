function [ img_lpf ] = lpf( img, N )
%Blurs the input img with an impulse response matrix of size N with
%constant values 1/N^2.
% Assumes that the img has already been read and is in the correct format.

H = zeros(N,N);
H(1:N,1:N) = 1 ./ pow2(N);

img_lpf = uint8(conv2(img,H));
end

