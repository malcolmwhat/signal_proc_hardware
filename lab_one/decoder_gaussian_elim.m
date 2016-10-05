function [ m ] = decoder_gaussian_elim( r )
% Use gaussian elimination to determine the correct message.
% Decodes up to two erasures perfectly. Does not attempt to decode more 
% than 2 bit errors.
% Arguments:
%   r : The received message, with erasures applied.
% Output Arguments:
%   m : The message extracted from the input message.
    
    % Index the erasures in the received message
    er_ind = find(r==0.5);
    
    
    % If there are more than two erasures it is possible gausian
    % elimination will not work. We also check if there are any erasures 
    % in the message part of the received code, and if not, we simply
    % return the message part of the code.
    if length(er_ind) < 3 && (sum(r(1:3)==0.5)>0)
        % Basically until we've resolved all erasures we check each of the
        % equations manually, one by one.
        while ~isempty(er_ind)
            
            % Get each of the received bits for the first equation
            equ1 = [r(1), r(2), r(4)];
            equ1_ind = [ 1 2 4 ];
            % Index all of the erasures in this equation
            ers1 = find(equ1==0.5); 
            
            % Only resolve if there is EXACTLY one erasure in this
            % particular equation
            if length(ers1)==1
                % Set the erasures to 0 temporarily so that the value
                % evaluates correctly
                equ1(equ1==0.5) = 0;
                
                % Set the value in the message to the sum modulo 2 of the
                % other two terms in the equation.
                r(equ1_ind(ers1(1))) = mod(sum(equ1),2);
            end
            
            % Same as previous logic but for equation 2
            equ2 = [r(1), r(3), r(5)];
            equ2_ind = [ 1 3 5 ];
            ers2 = find(equ2==0.5);
            equ2(equ2==0.5) = 0;
            if length(ers2)==1
                r(equ2_ind(ers2(1))) = mod(sum(equ2),2);
            end
            
            % Same as previous logic but for equation 3           
            equ3 = [r(2), r(3), r(6)];
            equ3_ind = [ 2 3 6 ];
            ers3 = find(equ3==0.5);
            equ3(equ3==0.5) = 0;
            if length(ers3)==1
                r(equ3_ind(ers3(1))) = mod(sum(equ3),2);
            end
            
            % Remake our erasure index in case we need to re-itterate (for
            % instance there could have been two erasures in the first eq
            % and only one in subsequent equations, so we would need to go
            % back and re-evaluate the first equation.
            er_ind = find(r==0.5);
        end
    end
    
    % Return the message bits
    m = r(1:3);
end

