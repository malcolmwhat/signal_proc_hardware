function [ m ] = decode( r )
% Decode the input code by eliminating erasures then syndrome decoding.

% Find the erasure indeces.
erasure_vector = r==0.5;
% As well as the set of non erased indeces.
no_erasure_vector = ~erasure_vector;

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
if sum(erasure_vector) == 0
    % Calculate G and H then do syndrome decoding.
    G = encode(eye(5));
    H = horzcat(G(:,6:16)',eye(11));
    r_hat = syndrome_correction(r,H,3);
% Case 2.
elseif sum(erasure_vector) > 7
    r_hat = r;
    r_hat(erasure_vector) = 0;
% Case 3.
elseif sum(erasure_vector(1:5)) == 0
    % Calculate G the normal way, then remove the column with erased parities.
    G = encode(eye(5));
    G_hat = G(:,no_erasure_vector);
    P = G_hat(:,6:length(G_hat));

    [ P_rows, P_columns ] = size(P); %#ok<ASGLU>

    % Calculate the new H matrix the same way we would normaly, taking the
    % dynamic size of P into consideration.
    H_hat = [ P' eye(P_columns) ];

    % Only consider the non-erased portion of the received code.
    r_w0_erasures = r(no_erasure_vector);

    % Number of errors we can expect to decode. dmin-1-erasures / 2.
    num_errs = floor((7-sum(erasure_vector))/2);

    % Attempt syndrome error correction.
    r_hat = syndrome_correction(r_w0_erasures,H_hat,num_errs);

% Case 4.
else
    % Determine H matrix Manually. We will only keep non-erased parities.
    G = mod(encode(eye(5)),2);
    G_hat = G(:,no_erasure_vector);
    
    % G_hat will not be in rre form, so do row reduction.
    G_hat_red = mod(rref(G_hat),2);
    
    if (sum(G_hat_red(5,:))==0)
        G_hat_red = G_hat_red(1:4,:);
    end
    
    [ g_height, g_width ] = size(G_hat_red);
    
    left_lim = g_height+1;
    
    P = G_hat_red(:,left_lim:g_width);
    
    H_hat = [ P' eye(g_width - g_height)];
    
    r_w0_era = r(no_erasure_vector);
    
    num_errs = floor((7-sum(erasure_vector))/2);
    
    c_hat = syndrome_correction(r_w0_era, H_hat, num_errs);
    
    r_hat = zeros(1,16);
    j = 1;
    for i = 1:16
        if no_erasure_vector(i)
            r_hat(i) = c_hat(j);
            j = j + 1;
        else
            r_hat(i) = 0.5;
        end
    end
    
    
    if sum(erasure_vector) < 7
        count = 1;
        while sum(erasure_vector) && count < 10
            equns = [
                1 2 3 6;
                1 2 4 7;
                1 2 5 8;
                1 3 4 9;
                1 3 5 10;
                1 4 5 11;
                2 3 4 12;
                2 3 5 13;
                2 4 5 14;
                3 4 5 15;
            ];
            
            for i = 1:10
                eq = equns(i,:);
                r_eq = r_hat(eq);
                ers = find(r_eq==0.5);
                
                if length(ers)==1
                    r_eq(eq==0.5) = 0;
                    r_hat(eq(ers(1))) = mod(sum(r_eq),2);
                end
            end
            eq = [1 2 3 4 5 16];
            r_eq = r_hat(eq);
            ers = find(r_eq==0.5);

            if length(ers)==1
                r_eq(eq==0.5) = 0;
                r_hat(eq(ers(1))) = mod(sum(r_eq),2);
            end
            count = count + 1;
        end
    end
end

% The decoded message is the first 5 bits of the input message.
m = r_hat(1:5);
end
