function [ distance ] = distance( c1, c2 )
%DISTANCE Simple wrapper for the pdist function
% Arguments:
%   c1: first code word
%   c2: second code word
% Return:
%   distance: Integer number, number of bit positions that are diferrent

    x = [c1; c2];
    distance = pdist(x,'hamming') * size(x,2);
end

