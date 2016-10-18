%% Implement bruteforce solution for gaussian noise decoding
% Inline approximations of the # of floating point opperations
% Assume we consider each element of the matrix and ignore any 
% optimizations that Matlab does behind the scenes
bin =  generate_binary_values(4);
vals = zeros(16,8);
diffs = zeros(16, 8);
r = [0.54 -0.12 1.32 0.41 0.63 1.25 0.37 -0.02];


for i = 1:length(bin)
    vals(i,:) = encoder_844(bin(i,:));
    diffs(i,:) = vals(i,:) - r; % 8 floating point subtractions
end % 8 * 16 = 128 floating point subtractions

% squaring: 128 multiplications
% summing, assume culmulative: 7 per row --> 7*16 = 112 additions
% Min, assume culmulative: 7 comparisons
[M, I] = min(sum(diffs.^2, 2));

% total number of comparisons: 128 subs, 128 mults, 112 adds, 7 comps
result = vals(I,:)