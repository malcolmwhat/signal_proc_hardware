function [ m_eras ] = error_channel( m, Pe )
% Applies errors to input based on the probability of erasure per bit. 
% Arguments: 
%   m : The bit vector input message
%   Pe : The probability (0,1) of an error happening on any bit
% Returns:
%   m_eras : the input vector with bit flip errors applied


% vector of the same length as m where -1/2 indicates erasure
E = (rand(1, length(m)) < Pe);

% Erasure on 0 will give -1/2 -> abs : 1/2. Erasure on 1 will give 1/2.
m_eras = mod(m + E, 2);

end

