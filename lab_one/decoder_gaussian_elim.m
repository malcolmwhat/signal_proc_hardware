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
    inter_r = r;
    inter_r(r==0.5) = 0;
    
    
    % If there are more than three erasures there is no way gausian
    % elimination will work
    if(length(er_ind) <= 3 && ~isempty(er_ind))
        % Message bits
        m1 = inter_r(1);
        m2 = inter_r(2);
        m3 = inter_r(3);

        % Parity bits
        p1 = inter_r(4);
        p2 = inter_r(5);
        p3 = inter_r(6);

        % Generate the vector R for the gaussian elimination eqn. A*e = R
        R = [ mod(m1+m2+p1, 2); mod(m1+m3+p2, 2); mod(m2+m3+p3, 2) ];
        
        eqn1 = [ 1 2 4 ];
        eqn2 = [ 1 3 5 ];
        eqn3 = [ 2 3 6 ];
        

	% Generate the A matrix for gaussian elim
        A = [];
        for k = 1:length(er_ind)
            A = horzcat(A, [g_mat(er_ind,k,eqn1);g_mat(er_ind,k,eqn2);g_mat(er_ind,k,eqn3)]);
        end
    
        erasure_corrected_vector = transpose(A\R); % in A * x = R, this gives x
        
        c_intermediate = inter_r;
        for i = 1:length(er_ind)
            c_intermediate(er_ind(i)) = erasure_corrected_vector(i);
        end
        
        c = abs(c_intermediate);
        
        m = c(1:3);
    elseif (isempty(er_ind))
        m = r(1:3);
    else
	m = [NaN NaN NaN];
    end
end

