function [ output_args ] = awgn( image, snr )
%AWGN Add gaussian noise to some image with some snr

power_signal = mean(mean(image));
power_noise = power_signal / 10^(snr / 20);

noise = randn(size(image)) * power_noise;

output_args = uint8(double(image) + noise);

end

