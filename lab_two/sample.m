function [ file_sampled ] = sample( rate, x )
%SAMPLE Summary of this function goes here
%   Detailed explanation goes here

% x = audioread(file);
legth = floor(size(x, 1)/rate);
file_sampled=zeros(legth, 1);
for i = 1:legth
    file_sampled(i) = x(i*rate);
end

end

