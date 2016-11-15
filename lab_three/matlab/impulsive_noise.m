function [ image_out, snr_out ] = impulsive_noise( image, noise_prob )
%IMPULSIVE_NOISE 

noise = rand(size(image));
for x = 1:size(noise, 1)
    for y = 1:size(noise, 2)
        if noise(x,y) < noise_prob
            noise(x,y) = 127;
        else
            noise(x,y) = 0;
        end
    end
end
image_out = image + uint8(noise);
snr_out = snr(image, noise);

end

