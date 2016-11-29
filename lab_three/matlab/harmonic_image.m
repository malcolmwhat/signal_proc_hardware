function [image] = harmonic_image(n, freq)
[X,Y] = meshgrid(linspace(-pi,pi,n));
sinewave2D=sin(freq*X);
image = sinewave2D;
end