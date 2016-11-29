function [ img_hpf ] = hpf( img )
% High pass filter the input image

H = [ 0, -1/4, 0; -1/4, 1, -1/4; 0 , -1/4, 0];

img_hpf = conv2(img,H);
end

