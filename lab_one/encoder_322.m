function [ code ] = encoder_322( data )
% Encode a 2 bit message using the (3, 2, 2) code.
% Input: 
%   data: n x 2 matrix of messages to encode, each row is a message [m1 m2]
%
% Output: 
%   code: generated codewords with parity bits added according to the following
%       p1 = (m1 + m2) % 2

code = zeros(size(data,1), 3);
for i = 1:size(data,1)
    %extract bits
    m1 = data(i, 1);
    m2 = data(i, 2);

    %compute parity
    p1 = mod((m1 + m2), 2);

    code_i = [m1 m2 p1];
    code(i,:) = code_i;
end

