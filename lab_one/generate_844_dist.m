% Generate the distances between all (8,4,4) codewords.

x = generate_binary_values(4)
y = []
for i = 1:length(x)
    y(i,:) = encoder_844(x(i,:))
end

z = []
for j = 1:length(y)
    for k=1:j
        z(j,k) = distance(y(j,:),y(k,:))
    end
end

latex(sym(z))

r = []
for t = 1:16
    r(t,1) = sum(y(t,:))
end

figure
h = histogram(r)
h.BinLimits = [0,8];

xlabel({'Distance'},'FontSize',11);
title({'(8,4,4) Code Spectrum'},'FontSize',11);
ylabel({'Frequency'},'FontSize',11);