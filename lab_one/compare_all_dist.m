enc = encoder_633(generate_binary_values(3) );
table = zeros(size(enc));
for i = 1:size(enc,1)
for j = 1:size(enc,1)
table(i,j) = distance(enc(i,:), enc(j,:));
end
end
for i = 1:size(table,1)
    for j = j+1:size(table,1)
        output(i+j) = table(i,j);
    end
end
% output(3:size(output,1)-1)

figure
h = histogram(output(3:15));
h.BinLimits = [0,6];

xlabel({'Distance'},'FontSize',11);
title({'(6, 3, 3) Code Spectrum'},'FontSize',11);
ylabel({'Frequency'},'FontSize',11);
