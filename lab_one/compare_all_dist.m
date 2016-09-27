clc; clear;
enc = encoder_633(generate_binary_values(3) );
table = zeros(size(enc));

for i = 1:size(enc,1)
    for j = 1:size(enc,1)
        table(i,j) = distance(enc(i,:), enc(j,:));
    end
end

for i = 1:size(table,1)
    for j = i+1:size(table,1)
        table(i,j) = 0;
    end
end

figure
h = histogram(table);
h.BinLimits = [1,6];

xlabel({'Distance'},'FontSize',11);
title({'(6, 3, 3) Code Spectrum'},'FontSize',11);
ylabel({'Frequency'},'FontSize',11);
