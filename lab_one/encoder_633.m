function [ code ] = encoder_633( data )
% Encode a 3 bit message using the (6, 3, 3) code.
% Input: 
%   data: n x 3 matrix of messages to encode, each row is a message [m1 m2 m3]
%
% Output: 
%   code: generated codewords with parity bits added according to the following
%       p1 = (m1 + m2) % 2
%       p2 = (m1 + m3) % 2
%       p3 = (m2 + m3) % 2

code = zeros(size(data,1), 6);
for i = 1:size(data,1)
    %extract bits
    m1 = data(i, 1);
    m2 = data(i, 2);
    m3 = data(i, 3);

    %compute parity
    p1 = mod((m1 + m2), 2);
    p2 = mod((m1 + m3), 2);
    p3 = mod((m2 + m3), 2);

    code_i = [m1 m2 m3 p1 p2 p3];
    code(i,:) = code_i;
end

