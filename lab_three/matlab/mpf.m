function [ img_mpf ] = mpf( img, N )
% Do a mid pass filter of size N
img_mpf = img;

N_t = ceil(N/2);

for i = N_t:(size(img,1)-N_t+1)
    for j = N_t:(size(img,2)-N_t)
        temp_mat = img(i-N_t+1:i+N_t-1,j-N_t+1:j+N_t-1);
        flat_list = reshape(temp_mat,1,(N).*(N));
        
        med = median(flat_list);
        img_mpf(i,j) = med;
    end
end
end

