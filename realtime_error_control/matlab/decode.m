function [ m ] = decode( r )
% Decode the input code by eliminating erasures then syndrome decoding.

% Find the erasure indeces.
erasure_vector = r==0.5;
% As well as the set of non erased indeces.
no_erasure_vector = zeros(1,16) - erasure_vector;

% There are a few cases of what could be erased:
% Case 1: There are no erasures.
%         This is easy to deal with. We simply do syndrome decoding.
% Case 2: There are too many erasures to decode.
% Case 3: There are erasures, but only in the parity bits.
%         Still fairly simple. We get G the traditional way, then we
%         eliminate the columns for which there are erasures, recalculate
%         the H matrix, calculate the syndrome table, and find the syndrome
%         for the input.
% Case 4: There are erasures, some appearing in the message bits.
%         In this case we need to manually determine the H matrix of the
%         code. This is done by writing out the parity equations for each
%         of the parity bits (at least the one without erasures) and then
%         row reducing out the erased message bit. Once row reduced the
%         rows containing the erased message bits can be removed from the H
%         matrix, as they no longer provide any information in the error
%         correction process. It should be noted that the parity bits with
%         erasures will also not be considered in the parity equations
%         included in the H matrix.
% Final Remark:
%         Since the minimum distance for our code is 8, we can think of our
%         erasure + error correction equation as d - 1 > era + err * 2 so the
%         number of errors that can be corrected is (7 - era) / 2. This impacts
%         our syndrome decoding. If we have 6 or 7 erasures, we can not correct
%         errors. If we have 4 or 5 erasures we can correct 1 error, if we have
%         2 or 3 erasures we can correct 2 errors and if we have 0 or 1 erasure
%         we can correct 3 errors.

% Case 1.
if isempty(erasure_vector)
    % Calculate G and H then do syndrome decoding.
    G = encode(eye(5));
    H = horzcat(G(:,6:16)',eye(11));
    r_hat = decode_syndrome(r,H,3);
% Case 2.
elseif length(erasure_vector) > 7
    r_hat = r;
    r_hat(erasure_vector) = 0;
% Case 3.
elseif erasure_vector(1) > 5
    % Calculate G the normal way, then remove the column with erased parities.
    G = encode(eye(5));
    G_hat = G(no_erasure_vector);
    P = G_hat(:,6:length(G_hat));

    % Calculate the new H matrix the same way we would normaly, taking the
    % dynamic size of P into consideration.
    H_hat = [ P' eye(length(P)) ];

    % Only consider the non-erased portion of the received code.
    r_w0_erasures = r(no_erasure_vector);

    % Number of errors we can expect to decode. dmin-1-erasures / 2.
    num_errs = floor((7-length(erasure_vector))/2);

    % Attempt syndrome error correction.
    r_hat = decode_syndrome(r_w0_erasures,H_hat,num_errs);

% Case 4.
else

end

% The decoded message is the first 5 bits of the input message.
m = r_hat(1:5);
end
