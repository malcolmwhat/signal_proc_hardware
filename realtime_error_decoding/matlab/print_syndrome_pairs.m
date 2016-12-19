%% Print the syndrome to error pairs to a file for use in VHDL.

fid = fopen('syndrome_pairs.txt', 'w');
error_vectors = [ zeros(1,16); permpos(1,16); permpos(2,16); permpos(3,16) ];

G = encode(eye(5));
H = horzcat(G(:,6:16)',eye(11));

syndromes = mod(error_vectors*H',2);

error_vector_strings = [];

syndrome_vector_strings = [];
formatSpec = 'when "%s" => error_vector <= "%s";\n';

for i = 1:length(error_vectors)
    err_char_arr = mat2str(error_vectors(i,:));
    error_vector_strings = vertcat(error_vector_strings, err_char_arr((1:16)*2));
    
    synd_char_arr = mat2str(syndromes(i,:));
    syndrome_vector_strings = vertcat(syndrome_vector_strings, synd_char_arr((1:11)*2));
    fprintf(fid,formatSpec, syndrome_vector_strings(i,:), error_vector_strings(i,:));
end