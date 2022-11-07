A = arfread('C:\Users\yding35\Box\ABR\ABR raw data\07202021\CLN3_5Month_F1(L2)\CLN3_5Month_F1(L2).arf');
m = squeeze(cell2mat(struct2cell(struct('data', {A.groups.recs(3).data}))));
m = m';
nFrame = 244;
timeV = (1:nFrame)/25000 * 1000;
figure;
plot(timeV,m);