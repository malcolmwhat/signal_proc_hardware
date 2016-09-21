function [ output] = generate_binary_values( bits )
%generate_binary_values Generate all possible binar string of some width
%   Atguments:
%       bits: width in bits of the string

output = zeros(2^bits, bits);

value = 0;
for col = 1:bits
    row = 0;
    for rep = 1:2^(bits-col+1)
        for item = 1: 2^(col-1)
            row = row + 1;
            output(row, bits-col+1) = value;
        end
        value=mod (value + 1, 2);
    end
end

end

