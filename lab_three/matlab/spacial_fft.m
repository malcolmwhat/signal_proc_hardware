function [F] =  spacial_fft (img)
F = fft2(img);
F = fftshift(F);
F = abs(F);
F = log(F+1);
F = mat2gray(F);
F = mat2gray(F);
end

