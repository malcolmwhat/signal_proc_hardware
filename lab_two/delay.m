function [ echo ] = delay( x, delay )
%DELAY Summary of this function goes here
%   Detailed explanation goes here

echo = [x; zeros(delay,1)] + [zeros(delay,1); x];

end

