function [ image_out ] = quantization( image, quantization_bits )
%QUATIZATION 

quantize_levels = 2^quantization_bits-1;
image = double(image);
image_out = image / 255;
image_out = double(uint8(image_out * quantize_levels));
image_out = uint8(image_out / quantize_levels * 255);

end

