function [ m ] = decoder_gaussian_elim( r )
% Use gaussian elimination to determine the correct message.
% Decodes up to two erasures perfectly. Can decode 3 erasures in special
% cases. Does not attempt to decode more than 3 bit errors.
% Arguments:
%   r : The received message, with erasures applied.
% Output Arguments:
%   m : The message extracted from the input message.
    
    er_ind = find(r==0.5);
    
    % Now set the errasures to 0
    r(r == 0.5) = 0;
    
    if(length(er_ind) == 0)
        m = r(1:3);
    end
    
    % If there are more than three erasures there is no way gausian
    % elimination will work
    if(length(er_ind) <= 3)
        % Message bits
        m1 = r(1);
        m2 = r(2);
        m3 = r(3);

        % Parity bits
        p1 = r(4);
        p2 = r(5);
        p3 = r(6);

        % Generate the vector R for the gaussian elimination eqn. A*e = R
        R = [ mod(m1+m2+p1, 2); mod(m1+m3+p2, 2); mod(m2+m3+p3, 2) ];
        
        eqn1 = [ 1 2 4 ];
        eqn2 = [ 1 3 5 ];
        eqn3 = [ 2 3 6 ];
        
        % Generate the A matrix for gaussian elim
        A = [
            g_mat(er_ind,1,eqn1) g_mat(er_ind,2,eqn1) g_mat(er_ind,3,eqn1);
            g_mat(er_ind,1,eqn2) g_mat(er_ind,2,eqn2) g_mat(er_ind,3,eqn2);
            g_mat(er_ind,1,eqn3) g_mat(er_ind,2,eqn3) g_mat(er_ind,3,eqn3);
        ];
    
        erasure_corrected_vector = transpose(A\R); % in A * x = R, this gives x
        
        c_intermediate = r;
        for i = 1:length(er_ind)
            c_intermediate(er_ind(i)) = erasure_corrected_vector(i);
        end
        
        c = c_intermediate;
        
        m = c(1:3);
    else
        m = [NaN NaN NaN];
    end
end

