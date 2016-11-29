n = 600;
freq = 1;
[X,Y] = meshgrid(linspace(-pi,pi,n));
sinewave2D=sin(freq*X);
plot(sinewave2D) 
imshow(sinewave2D) 