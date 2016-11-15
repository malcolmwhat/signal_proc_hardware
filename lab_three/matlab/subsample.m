function [ image_output ] = subsample( image, sample_rate )
%SUBSAMPLE Sub-sampling of an image by some arbitrary rate

total_height = size(image, 1);
total_width = size(image, 2);

current_height = 1;
current_width = 1;

while current_height <= total_height
    while current_width <= total_width
        new_value = image(current_height, current_width);
        image(current_height:current_height + sample_rate - 1, current_width:current_width + sample_rate - 1) = new_value;
        current_width = current_width + sample_rate;
    end   
    current_height = current_height + sample_rate;
    current_width = 1;
end
image_output = image;
end

