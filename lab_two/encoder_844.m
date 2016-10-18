function [ c ] = encoder_844( m )
% Encodes the 4 bit message m to the 8 bit codeword based on the (8,4,4)
% encoding scheme.

% Get the parities
p = [];
p(1) = mod(m(1) + m(2) + m(3), 2);
p(2) = mod(m(1) + m(2) + m(4), 2);
p(3) = mod(m(1) + m(3) + m(4), 2);
p(4) = mod(m(2) + m(3) + m(4), 2);

c = horzcat(m, p);
end
