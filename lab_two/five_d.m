function [ solution ] = five_d(coef, res)
% Solves the 4 equation with 4 unknown system of equations represented by
% coef by comparing against res and using mod-2 arithmetic.

% We can not give the result for this if we do not have independent coefs.
if(rank(coef) == 4)
    solution = zeros(4,1);
    solved_positions = zeros(4,1);

    while sum(solved_positions)<4
        change = 0;
        for i = 1:4
            %Only can actually properly decide if there is exactly one unknown
            current_row = coef(i,:);
            number_of_unknowns = current_row * ~solved_positions;
            if number_of_unknowns == 1
                change = 1;
                index = find(and(current_row, ~solved_positions'),1);
                solved_indeces = find(solved_positions);
                cur_row_solved = current_row(solved_indeces);
                sols = solution(solved_indeces);
                solution(index) = mod(sum(and(cur_row_solved, sols'))+res(i),2);
                solved_positions(index) = 1;
            end
        end
        %If we have to, we just set the first unsolved spot to 1.
        if ~change
            ind = find(~solved_positions,1);
            solution(ind) = 1;
            solved_positions(ind) = 1;
        end
    end
end
