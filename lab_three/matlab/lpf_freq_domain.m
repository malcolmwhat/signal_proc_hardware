function [ img_lpf ] = lpf_freq_domain( img, K0 )
% Filter the image with the given cutoff_freq in the frequency domain.

kit_ft = fft2(img);
% Get dimensions.
[N,M] = size(kit_ft);
% Set sampling intervals.
dx = 1;
dy = 1;

% Compute the characteristic wavelengths.
KX0 = (mod(1/2 + (0:(M-1))/M, 1) - 1/2);
KX1 = KX0 * (2*pi/dx);
KY0 = (mod(1/2 + (0:(N-1))/N, 1) - 1/2);
KY1 = KY0 * (2*pi/dy);
[KX,KY] = meshgrid(KX1, KY1);
% Form filter.
lowpass = (KX.*KX + KY.*KY <= K0^2);
% Filter
img_lpf = ifft2(lowpass.*kit_ft);
end

